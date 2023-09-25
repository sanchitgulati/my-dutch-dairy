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
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          keyboardType: TextInputType.multiline,
          maxLines: 10,
          minLines: 5,
          onChanged:
              handleTextChange, // Call this function when the text field changes
          decoration: const InputDecoration(
            labelText: 'How did you start your morning?', // Placeholder text
            hintText: 'Type something', // Shown when the field is empty
            prefixIcon: Icon(Icons.text_fields), // Optional icon prefix
            // You can add more decoration options here, like border, labelStyle, etc.
          ),
          // Other properties like controller, onChanged, etc. can be added here
        ),
      ],
    )); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
