import 'package:diary_app/entities/journal.dart';
import 'package:diary_app/entities/story.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'database_helper.dart';
import 'package:uuid/uuid.dart';

class DataStore extends ChangeNotifier {
  Random random = Random();
  List<StoryEntity> availableStoriesList = [];
  var currentText = "";
  final Journal _entry =
      Journal(millisecondsSinceEpoch: 0, heading: "", text: "");

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

  Future<StoryEntity> getNext() async {
    var lru = await DatabaseHelper().getRandomInventoryId();
    var q = availableStoriesList[
        lru ?? random.nextInt(availableStoriesList.length)];
    return q;
  }

  void updateTextField(String newValue) {
    _entry.text = newValue;
  }

  List<String> parseList(String input) {
    return input
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll("'", '')
        .split(', ')
        .map((e) => e.trim())
        .toList();
  }

  void newStory() {
    var uuid = const Uuid();
    _entry.id = uuid.v4();
  }

  bool save() {
    if (_entry.text.isEmpty || _entry.text.length < 10) {
      return false;
    }
    _entry.heading = DateFormat('dd_MMM_yyyy').format(selectedDate);
    _entry.millisecondsSinceEpoch = DateTime.now().millisecondsSinceEpoch;
    _databaseHelper.insertOrUpdate(_entry);
    notifyListeners();

    return true;
  }

  void delete(String id) {
    _databaseHelper.delete(id);
    notifyListeners();
  }
}
