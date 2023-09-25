import 'package:flutter/material.dart';

class PillWidget extends StatefulWidget {
  final String label;
  final String label2;

  PillWidget({required this.label, required this.label2});

  @override
  _PillWidgetState createState() => _PillWidgetState();
}

class _PillWidgetState extends State<PillWidget> {
  int index = 0;

  void onClick() {
    setState(() {
      index = (index + 1) % 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onClick,
      child: index == 0 ? Text(widget.label) : Text(widget.label2),
    );
  }
}
