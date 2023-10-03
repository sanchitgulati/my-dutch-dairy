import 'package:diary_app/journal.dart';
import 'package:diary_app/question_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'database_helper.dart';

class DataStore extends ChangeNotifier {
  Random random = Random();
  List<StoryEntity> availableStoriesList = [];
  var currentText = "";
  StoryEntity selectedQuestion = StoryEntity(text: "", words: []);

  var selectedDate = DateTime.now();

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  DataStore() {
    init();
  }

  // Fetch data from the database
  Future<List<Journal>> getDataFromDatabase() async {
    return _databaseHelper.retrieve();
  }

  Future<void> init() async {
    try {
      final String data = await rootBundle.loadString('assets/stories.tsv');
      final List<String> lines = LineSplitter.split(data).toList();

      for (int i = 1; i < lines.length; i++) {
        final List<String> values = lines[i].split('\t');
        if (values.length >= 2) {
          availableStoriesList
              .add(StoryEntity(text: values[0], words: parseList(values[1])));
        }
      }
    } catch (e) {
      print('Error loading Q&A data: $e');
    }
  }

  void getNext() async {
    var lru = await DatabaseHelper().getRandomInventoryId();
    var q = availableStoriesList[
        lru ?? random.nextInt(availableStoriesList.length)];
    print(q);
  }

  void updateTextField(String newValue) {
    // selectedQuestion.text = newValue;
    // notifyListeners();
  }

  // void onRefresh() {
  //   _pickRandomQnA();
  // }

  void _pickRandomQnA() {}

  List<String> parseList(String input) {
    return input
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll("'", '')
        .split(', ')
        .map((e) => e.trim())
        .toList();
  }

  void save() {}

  void loadId() {
    DatabaseHelper().retrieve();
  }

  // void getState(DateTime date) {
  //   var storedData = storage.getItem(DateFormat('dd_MMM_yyyy').format(date));
  //   QnA q;
  //   if (storedData != null) {
  //     q = QnA.fromJson(storedData);
  //     _pickQ(q);
  //     currentText = q.text;
  //   } else {
  //     _pickRandomQnA();
  //   }
  //   notifyListeners();
  // }

  // void clearStorage() async {
  //   await storage.clear();
  //   notifyListeners();
  // }

  // void onQuestionChange(int id) {
  //   notifyListeners();
  // }

  // void onDateChange(DateTime date) {
  //   selectedDate = date;
  //   getState(date);
  // }
}
