import 'dart:io';

import 'package:farmer/page/previously_recommended.dart';
import 'package:farmer/page/recommend.dart';
import 'package:farmer/profile.dart';
import 'constants.dart' as globals;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:farmer/utils/utils.dart';
import 'package:farmer/widget/button_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  bool loading = false;
  File? _image;
  final picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseRef =
      FirebaseDatabase.instance.ref('Username/name');

  Future getImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('no image picked');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Upload Image'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      getImageGallery();
                    },
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: _image != null
                          ? Image.file(_image!.absolute)
                          : Center(child: Icon(Icons.image)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                RoundButton(
                    title: 'Upload',
                    loading: loading,
                    onTap: () async {
                      setState(() {
                        loading = true;
                      });
                      String now =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      firebase_storage.Reference ref = firebase_storage
                          .FirebaseStorage.instance
                          .ref('/abrar/' + now);
                      firebase_storage.UploadTask uploadTask =
                          ref.putFile(_image!.absolute);

                      Future.value(uploadTask).then((value) async {
                        var newUrl = await ref.getDownloadURL();

                        databaseRef.child(globals.my).set({
                          'pro': newUrl.toString(),
                        }).then((value) {
                          setState(() {
                            loading = false;
                          });
                          Utils().toastMessage('uploaded');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Profile()),
                          );
                        }).onError((error, stackTrace) {
                          print(error.toString());
                          setState(() {
                            loading = false;
                          });
                        });
                      }).onError((error, stackTrace) {
                        Utils().toastMessage(error.toString());
                        setState(() {
                          loading = false;
                        });
                      });
                    }),
                SizedBox(height: 50),
              ],
            ),
          ),
        ));
  }
}
