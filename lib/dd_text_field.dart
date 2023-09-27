import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class DdTextField extends StatefulWidget {
  const DdTextField({super.key, required this.title});

  final String title;

  @override
  State<DdTextField> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DdTextField> {
  String inputValue = ''; // Variable to store the current text field value

  // Function to be called when the text field value changes
  void handleTextChange(String value) {
    setState(() {
      inputValue = value; // Update the inputValue variable
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CustomPaint(
      foregroundPainter: PagePainter(),
      child: TextField(
        keyboardType: TextInputType.multiline,
        minLines: 10,
        maxLines: null,
        onChanged:
            handleTextChange, // Call this function when the text field changes
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Type something', // Shown when the field is empty
        ),
        // Other properties like controller, onChanged, etc. can be added here
      ),
    )); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

class PagePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    for (var x = 0.0; x <= size.height; x += 40) {
      canvas.drawLine(
        Offset(0, x),
        Offset(size.width, x),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(PagePainter oldDelegate) => false;
}
