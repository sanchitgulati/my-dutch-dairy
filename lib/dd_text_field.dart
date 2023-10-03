import 'data_store.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class DdTextField extends StatefulWidget {
  const DdTextField({super.key, required this.text});
  final String text;
  @override
  State<DdTextField> createState() => _DdTextFieldState();
}

class _DdTextFieldState extends State<DdTextField> {
  TextEditingController _controller = TextEditingController();
  var text = "";

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
  }

  void editingComplete() {}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CustomPaint(
      foregroundPainter: PagePainter(),
      child: Consumer<DataStore>(
        builder: (context, dataStore, _) {
          // Update the text in the TextField when DataStore is updated
          _controller.text = dataStore.selectedQuestion.text;
          return TextField(
            controller: _controller,
            keyboardType: TextInputType.multiline,
            minLines: 10,
            maxLines: null,
            onChanged: (newValue) {
              context.read<DataStore>().updateTextField(_controller.text);
            },
            onEditingComplete: editingComplete,
            style: const TextStyle(
              fontSize: 16.0, // Adjust the font size as needed
              height: 1.9, // Adjust the line height (line spacing) as needed
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Type something', // Shown when the field is empty
            ),
            // Other properties like controller, onChanged, etc. can be added here
          );
        },
      ),
    )); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

class PagePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(128, 29, 133, 181)
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    for (var x = 10.0; x <= size.height; x += 30.5) {
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
