import 'package:flutter/material.dart';
import 'dart:math';
import 'package:paginated_search_bar/paginated_search_bar.dart';

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: irrigationh(),
    ));

class irrigationh extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Irrigation History',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Irrigation History'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DataTableSource _data = MyData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          backgroundColor: Color(0xff1fd655)),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [(new Color(0xffffffff)), new Color(0xff00f25f)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  "Enter your Date Range",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              SizedBox.square(
                dimension: 20,
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: PaginatedSearchBar<ExampleItem>(
                  onSearch: ({
                    required pageIndex,
                    required pageSize,
                    required searchQuery,
                  }) async {
                    // Call your search API to return a list of items
                    return [
                      ExampleItem(title: 'Item 0'),
                      ExampleItem(title: 'Item 1'),
                    ];
                  },
                  itemBuilder: (
                    context, {
                    required item,
                    required index,
                  }) {
                    return Text(item.title);
                  },
                ),
              ),
              PaginatedDataTable(
                source: _data,
                columns: const [
                  DataColumn(
                      label: Text(
                    "Field No",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.black),
                  )),
                  DataColumn(
                      label: Text(
                    "Crop Name",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.black),
                  )),
                  DataColumn(
                      label: Text(
                    "Water Used",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.black),
                  )),
                  DataColumn(
                      label: Text(
                    "Date",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.black),
                  ))
                ],
                columnSpacing: 30,
                horizontalMargin: 60,
                rowsPerPage: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> _data = List.generate(
      10,
      (index) => {
            "Field No": " $index",
            "Crop Name": "Crop $index",
            "Water Used": Random().nextInt(10000),
            "Date": "$index/10/2022",
          });

  final List<Map<String, dynamic>> _dat = List.generate(
      0,
      (index) =>
          {"Field No": "", "Crop Name": "", "Water Used": "", "Date": ""});

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(
        _data[index]['Field No'],
        style: TextStyle(fontSize: 20, color: Colors.blueGrey),
      )),
      DataCell(Text(
        _data[index]["Crop Name"].toString(),
        style: TextStyle(fontSize: 20, color: Colors.blueGrey),
      )),
      DataCell(Text(
        _data[index]["Water Used"].toString(),
        style: TextStyle(fontSize: 20, color: Colors.blueGrey),
      )),
      DataCell(Text(
        _data[index]["Date"],
        style: TextStyle(fontSize: 20, color: Colors.blueGrey),
      )),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => _data.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}

class ExampleItem {
  final String title;

  ExampleItem({
    required this.title,
  });
}
