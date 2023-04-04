import 'dart:io';

import 'package:farmer/page/previously_recommended.dart';
import 'package:farmer/page/recommend.dart';
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
  final imagename = TextEditingController();
  File? _image;
  final picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseRef =
      FirebaseDatabase.instance.ref('Username/name');

  Future getImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
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
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: imagename,
                  decoration: const InputDecoration(
                      hintText: 'Image Name',
                      prefixIcon: Icon(Icons.near_me_rounded)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your Name';
                    }
                    return null;
                  },
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

                        databaseRef.child(now).set({
                          'name': imagename.text.toString(),
                          'value': newUrl.toString(),
                          'type': '',
                          'suggestion': ''
                        }).then((value) {
                          setState(() {
                            loading = false;
                          });
                          Utils().toastMessage('uploaded');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => recommend()),
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
                SizedBox(
                  height: 50,
                ),
                Container(
                  color: Colors.blue,
                  child: Card(
                    elevation: 3,
                    child: ListTile(
                      title: Text(
                        "Previous Recommendations",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.blueGrey),
                      ),
                      subtitle: Text("last used 01/08/2022"),
                      trailing: Icon(Icons.label_important_outlined),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => previously()),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
