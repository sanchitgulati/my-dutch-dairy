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
  List<StoryEntity> qnaList = [];
  var currentText = "";
  StoryEntity selectedQuestion = StoryEntity(
      text: "", questionEnglish: "english", question: "question", words: []);
  final LocalStorage storage = LocalStorage('some_key');

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
        if (values.length >= 3) {
          qnaList.add(StoryEntity(
              startingText: values[0],
              question: values[1],
              text: "",
              words: parseKeyValuePairs(values[2])));
        }
      }
    } catch (e) {
      print('Error loading Q&A data: $e');
    }
    getState(DateTime.now());
  }

  void getNext() {}
  // void updateTextField(String newValue) {
  //   selectedQuestion.text = newValue;
  //   notifyListeners();
  // }

  // void onRefresh() {
  //   _pickRandomQnA();
  // }

  // void _pickRandomQnA() {
  //   if (qnaList.isNotEmpty) {
  //     final newQnAIndex = random.nextInt(qnaList.length);
  //     var question = qnaList[newQnAIndex].question;
  //     var words = qnaList[newQnAIndex].words;
  //     var questionEnglish = qnaList[newQnAIndex].questionEnglish;
  //     selectedQuestion = QnA(
  //         text: "",
  //         questionEnglish: questionEnglish,
  //         question: question,
  //         words: words);
  //     notifyListeners();
  //   }
  // }

  // void _pickQ(QnA q) {
  //   selectedQuestion = q;
  //   notifyListeners();
  // }

  // List<MapEntry<String, String>> parseKeyValuePairs(String input) {
  //   // Split the input string by "-" to separate the key-value pairs
  //   List<String> pairs = input.split('-');

  //   // Remove leading and trailing spaces from each pair and filter out empty strings
  //   pairs = pairs
  //       .map((pair) => pair.trim())
  //       .where((pair) => pair.isNotEmpty)
  //       .toList();

  //   // Initialize an empty list to store key-value pairs
  //   List<MapEntry<String, String>> keyValuePairs = [];

  //   // Iterate through the pairs and split them into keys and values
  //   for (var pair in pairs) {
  //     List<String> parts = pair.split('(');

  //     if (parts.length == 2) {
  //       String key = parts[0].trim();
  //       String value = parts[1].replaceAll(')', '').trim();

  //       // Create a MapEntry and add it to the list
  //       keyValuePairs.add(MapEntry(key, value));
  //     }
  //   }

  //   return keyValuePairs;
  // }

  // void save() {
  //   var jsonDump = selectedQuestion.toJson();
  //   storage.setItem(DateFormat('dd_MMM_yyyy').format(selectedDate), jsonDump);
  //   print("save: ");
  //   print(jsonDump);
  // }

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
