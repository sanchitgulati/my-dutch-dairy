import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_search_bar/flutter_search_bar.dart' as searchbar;

class SearchBarTableDemoHome extends StatefulWidget {
  @override
  _SearchBarTableDemoHomeState createState() => _SearchBarTableDemoHomeState();
}

class _SearchBarTableDemoHomeState extends State<SearchBarTableDemoHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late searchbar.SearchBar searchBar;
  List<List<dynamic>> tableData = [];
  List<List<dynamic>> filteredData = [];

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Search Bar Table Demo'),
      actions: [searchBar.getSearchAction(context)],
    );
  }

  void onSubmitted(String value) {
    _search(value);
  }

  _SearchBarTableDemoHomeState() {
    searchBar = searchbar.SearchBar(
      inBar: false,
      buildDefaultAppBar: buildAppBar,
      setState: setState,
      onSubmitted: onSubmitted,
      onCleared: () {
        setState(() {
          filteredData = tableData;
        });
      },
      onClosed: () {
        print("Search bar has been closed");
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loadCSVData();
  }

  Future<void> loadCSVData() async {
    String csvData = await rootBundle.loadString('assets/register.csv');
    List<List<dynamic>> csvTable = CsvToListConverter().convert(csvData);
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
      body: SingleChildScrollView(
        child: DataTable(
          columns: [
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
    );
  }
}
