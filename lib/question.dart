import 'package:flutter/material.dart';
import 'pills.dart';
import 'question_entity.dart';

class Question extends StatefulWidget {
  const Question({super.key, required this.q});
  final QnA q;

  @override
  // ignore: library_private_types_in_public_api
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  int index = 0;
  String displayText = "";

  void _handleTextTap() {
    setState(() {
      index = (index + 1) % 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<PillWidget> pillWidgets = [];
    if (index == 0) {
      displayText = widget.q.question;
    } else {
      displayText = widget.q.questionEnglish;
    }
    for (var i = 0; i < widget.q.words.length; i++) {
      pillWidgets.add(PillWidget(
        label: widget.q.words[i].key,
        label2: widget.q.words[i].value,
      ));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
            onTap: _handleTextTap, // Specify the function to call when tapped
            child: Text(
              displayText,
              style: const TextStyle(fontSize: 24),
            )),
        Row(
          children: pillWidgets,
        )
      ],
    );
  }
}
