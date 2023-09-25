import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';
import 'pills.dart';

class QnA {
  final String question;
  final List<MapEntry<String, String>> keyValuePairs;
  QnA({required this.question, required this.keyValuePairs});
}

class Question extends StatefulWidget {
  const Question({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  late List<QnA> qnaList;
  Random random = Random();
  int currentQnAIndex = -1;

  @override
  void initState() {
    super.initState();
    _loadQnAList();
  }

  List<MapEntry<String, String>> parseKeyValuePairs(String input) {
    // Split the input string by "-" to separate the key-value pairs
    List<String> pairs = input.split('-');

    // Remove leading and trailing spaces from each pair and filter out empty strings
    pairs = pairs
        .map((pair) => pair.trim())
        .where((pair) => pair.isNotEmpty)
        .toList();

    // Initialize an empty list to store key-value pairs
    List<MapEntry<String, String>> keyValuePairs = [];

    // Iterate through the pairs and split them into keys and values
    for (var pair in pairs) {
      List<String> parts = pair.split('(');

      if (parts.length == 2) {
        String key = parts[0].trim();
        String value = parts[1].replaceAll(')', '').trim();

        // Create a MapEntry and add it to the list
        keyValuePairs.add(MapEntry(key, value));
      }
    }

    return keyValuePairs;
  }

  Future<void> _loadQnAList() async {
    try {
      final String data = await rootBundle.loadString('assets/questions.tsv');
      final List<String> lines = LineSplitter.split(data).toList();
      final List<QnA> qnas = [];

      for (int i = 1; i < lines.length; i++) {
        final List<String> values = lines[i].split('\t');
        if (values.length >= 3) {
          qnas.add(QnA(
              question: values[1],
              keyValuePairs: parseKeyValuePairs(values[2])));
        }
      }

      setState(() {
        qnaList = qnas;
        _pickRandomQnA();
      });
    } catch (e) {
      print('Error loading Q&A data: $e');
    }
  }

  void _pickRandomQnA() {
    if (qnaList.isNotEmpty) {
      final newQnAIndex = random.nextInt(qnaList.length);
      setState(() {
        currentQnAIndex = newQnAIndex;
        final keyValuePairs = qnaList[currentQnAIndex].keyValuePairs;
        pillWidgets = keyValuePairs.map((entry) {
          return PillWidget(label: entry.key, label2: entry.value);
        }).toList();
      });
    }
  }

  List<PillWidget> pillWidgets = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (currentQnAIndex != -1)
          Text(
            qnaList[currentQnAIndex].question,
            style: const TextStyle(fontSize: 24),
          ),
        if (currentQnAIndex != -1)
          Column(
            children: pillWidgets,
          ),
        TextButton(
          onPressed: _pickRandomQnA,
          child: const Text('Refresh'),
        ),
      ],
    );
  }
}
