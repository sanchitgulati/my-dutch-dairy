import 'package:flutter/material.dart';
import 'horizontal_week_calendar.dart';
import 'package:intl/intl.dart';
import 'dd_text_field.dart';
import 'question.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:math';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _HorizontalWeekCalendarPackageState();
}

class JournalEntry {
  int questionId;
  String text;

  JournalEntry({required this.questionId, required this.text});

  toJSONEncodable() {
    Map<String, dynamic> m = Map();

    m['text'] = text;
    m['question'] = questionId;

    return m;
  }
}

class _HorizontalWeekCalendarPackageState extends State<Calender> {
  var selectedDate = DateTime.now();

  String _textFieldValue = '';
  int qId = -1;
  Random random = Random();

  void _updateTextField(String newValue) {
    setState(() {
      _textFieldValue = newValue; // Update the text value in the parent's state
    });
  }

  final LocalStorage storage = new LocalStorage('some_key');

  JournalEntry item = JournalEntry(questionId: 1, text: '');

  _addItem() {
    item.text = _textFieldValue;
    _saveToStorage();
  }

  _saveToStorage() {
    storage.setItem(
        DateFormat('dd_MMM_yyyy').format(selectedDate), item.toJSONEncodable());
    print("_saveToStorage " + item.toJSONEncodable().toString());
  }

  _getState() {
    setState(() {
      var temp =
          storage.getItem(DateFormat('dd_MMM_yyyy').format(selectedDate));
      if (temp != null) print("_getState " + temp['text']);
      print(selectedDate);
      if (temp != null) {
        print("_getState " + temp.toString());
        _textFieldValue = temp['text'];
        qId = temp['question'];
      } else {
        var newQnAIndex = random.nextInt(19);
        _textFieldValue = '';
        qId = newQnAIndex;
      }
      print(" in set State " + _textFieldValue);
    });
  }

  _clearStorage() async {
    await storage.clear();
  }

  void _onQuestionChange(int id) {
    print("_onQuestionChange " + id.toString());
    setState(() {
      item.questionId = id;
      _saveToStorage();
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    Widget selectedDateWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 5),
        Text(
          DateFormat('dd MMM yyyy').format(selectedDate),
          textAlign: TextAlign.center,
          style: theme.textTheme.titleLarge!.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ],
    );

    Widget textSection =
        Question(questionId: qId, onChanged: _onQuestionChange);

    void onDateChange(DateTime date) {
      setState(() {
        selectedDate = date;
      });
      _getState();
    }

    Widget dd = DdTextField(
      text: _textFieldValue,
      onChanged: _updateTextField,
    );

    Widget listView = ListView(children: [
      selectedDateWidget,
      textSection,
      dd,
      Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                _addItem();
              },
              child: const Text('Save'),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                _clearStorage();
              },
              child: const Text('Clear storage'),
            ),
          ),
        ],
      )
    ]);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // This line removes the back button
        title: const Text(
          "Schrijven",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              HorizontalWeekCalendar(
                  // weekStartFrom: WeekStartFrom.monday,
                  // activeBackgroundColor: Colors.purple,
                  // activeTextColor: Colors.white,
                  // inactiveBackgroundColor: Colors.purple.withOpacity(.3),
                  // inactiveTextColor: Colors.white,
                  // disabledTextColor: Colors.grey,
                  // disabledBackgroundColor: Colors.grey.withOpacity(.3),
                  // activeNavigatorColor: Colors.purple,
                  // inactiveNavigatorColor: Colors.grey,
                  // monthColor: Colors.purple,
                  onDateChange: onDateChange),
              Expanded(
                child: listView,
              )
            ],
          ),
        ),
      ),
    );
  }
}
