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
    return Center(
      child: GestureDetector(
        onTap: onClick,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            index == 0 ? widget.label : widget.label2,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
