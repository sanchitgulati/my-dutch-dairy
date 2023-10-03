import 'package:diary_app/data_store.dart';
import 'package:diary_app/question_entity.dart';
import 'package:flutter/material.dart';
import 'dd_text_field.dart';
import 'package:provider/provider.dart';

class Notepad extends StatefulWidget {
  const Notepad({Key? key}) : super(key: key);
  State<Notepad> createState() => NotepadState();
}

class NotepadState extends State<Notepad> {
  StoryEntity entity = StoryEntity(text: "", words: []);
  @override
  void initState() {
    super.initState();

    var idea = context.read<DataStore>().getNext();
    idea.then((value) => setState(() {
          entity = value;
          print("idea");
          print(entity.text);
        }));
  }

  @override
  Widget build(BuildContext context) {
    Widget buildWordChip(String word) {
      return Chip(
        label: Text(word),
      );
    }

    Widget dd = DdTextField(text: entity.text);

    var words = entity.words;
    Widget listView = ListView(children: [
      dd,
      const SizedBox(
        height: 20,
      ),
      Wrap(
        spacing: 10.0, // Adjust the spacing between words as needed
        runSpacing: 10.0, // Adjust the spacing between rows as needed
        children: words.map((word) => buildWordChip(word)).toList(),
      ),
      const SizedBox(
        height: 20,
      ),
      OutlinedButton(
        style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
        onPressed: () {
          context.read<DataStore>().save();
        },
        child: const Text('Done'),
      ),
    ]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maak een verhaal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).pushNamed('/vocab');
            },
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).popAndPushNamed('/home');
          },
        ),
      ),
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.all(10), child: listView),
      ),
    );
  }
}
