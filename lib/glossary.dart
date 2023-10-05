import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_search_bar/flutter_search_bar.dart' as searchbar;

class Glossary extends StatefulWidget {
  const Glossary({Key? key}) : super(key: key);

  @override
  GlossaryState createState() => GlossaryState();
}

class GlossaryState extends State<Glossary> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late searchbar.SearchBar searchBar;
  List<List<dynamic>> tableData = [];
  List<List<dynamic>> filteredData = [];

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Glossary'),
      actions: [searchBar.getSearchAction(context)],
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void onSubmitted(String value) {
    _search(value);
  }

  GlossaryState() {
    searchBar = searchbar.SearchBar(
      inBar: false,
      buildDefaultAppBar: buildAppBar,
      setState: setState,
      onSubmitted: onSubmitted,
      onChanged: onSubmitted,
      onCleared: () {
        setState(() {
          filteredData = tableData;
        });
      },
      onClosed: () {},
    );
  }

  @override
  void initState() {
    super.initState();
    loadCSVData();
  }

  Future<void> loadCSVData() async {
    String csvData = await rootBundle.loadString('assets/register.csv');
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(csvData);
    setState(() {
      tableData = csvTable;
      filteredData = csvTable;
    });
  }

  void _search(String keyword) {
    setState(() {
      filteredData = tableData.where((row) {
        return row[0]
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            row[1].toString().toLowerCase().contains(keyword.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
      key: _scaffoldKey,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Word')),
              DataColumn(label: Text('Meaning')),
            ],
            rows: filteredData.map((row) {
              return DataRow(
                cells: [
                  DataCell(Text(row[0].toString())),
                  DataCell(Text(row[1].toString())),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
