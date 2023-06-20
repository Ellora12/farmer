import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';

import '../constants.dart' as globals;

class irrigationh extends StatefulWidget {
  const irrigationh({Key? key}) : super(key: key);

  @override
  State<irrigationh> createState() => _irrigationhState();
}

class _irrigationhState extends State<irrigationh> {
  String ec = globals.my;
  final databaseRef = FirebaseDatabase.instance.ref().child('fieldwater');


  List<ExampleItem> monthlydata = [];
  List<ExampleItem> displayedData=[];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void fetchUsers() {
    DatabaseReference nodeRef = databaseRef.child("$ec/field1/Monthly");
    nodeRef.onValue.listen((event) {
      monthlydata.clear();
      Map<dynamic, dynamic>? values =
      event.snapshot.value as Map<dynamic, dynamic>?;
      values?.forEach((key, value) {
        monthlydata.add(
          ExampleItem(
            fieldno: 1,
            month: key,
            water: value,
          ),
        );
      });
      // update the UI with the fetched data
    }, onError: (error) {
      print('Failed to fetch data: $error');
    });

    DatabaseReference nodeRef3 = databaseRef.child("$ec/field2/Monthly");
    nodeRef3.onValue.listen((event) {
      Map<dynamic, dynamic>? values =
      event.snapshot.value as Map<dynamic, dynamic>?;
      values?.forEach((key, value) {
        monthlydata.add(
          ExampleItem(
            fieldno: 2,
            month: key,
            water: value,
          ),
        );
      });
      setState(() {
        displayedData = monthlydata;
      });
      // update the UI with the fetched data
    }, onError: (error) {
      print('Failed to fetch data: $error');
    });
  }

  Future<Uint8List> generatePdf(List<ExampleItem> data) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Table.fromTextArray(
            context: context,
            data: <List<String>>[
              <String>['Field No', 'Monthly', 'Water Used'],
              ...data.map((item) =>
              [item.fieldno.toString(), item.month, item.water.toString()]),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  Future<void> savePdf(Uint8List pdfBytes) async {
    final directory = await getExternalStorageDirectory();
    final file = File('${directory!.path}/irrigation_history.pdf');
    await file.writeAsBytes(pdfBytes);
    print('PDF saved to ${file.path}');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Irrigation History"),
        centerTitle: true,
        backgroundColor: const Color(0xff1fd655),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xffffffff), const Color(0xff00f25f)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              const SizedBox.square(
                dimension: 20,
              ),
              PaginatedDataTable(
                source: ExampleDataSource(displayedData),
                columns: const [
                  DataColumn(
                    label: Text(
                      "Field No",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Monthly",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Water Used",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
                columnSpacing: 30,
                horizontalMargin: 60,
                rowsPerPage: 8,
              ),
              ElevatedButton(
                onPressed: () => generateAndSavePdf(displayedData),
                child: Text('Download as PDF'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> generateAndSavePdf(List<ExampleItem> data) async {
    Uint8List pdfBytes = await generatePdf(data);
    await savePdf(pdfBytes);
  }
}

class ExampleItem {
  final int fieldno;
  final String month;
  final dynamic water;

  ExampleItem({
    required this.fieldno,
    required this.month,
    required this.water,
  });
}

class ExampleDataSource extends DataTableSource {
  final List<ExampleItem> data;

  ExampleDataSource(this.data);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(item.fieldno.toString())),
        DataCell(Text(item.month.toString())),
        DataCell(Text(item.water.toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}