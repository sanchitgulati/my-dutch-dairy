import 'package:diary_app/data_store.dart';
import 'package:flutter/material.dart';
import 'dd_text_field.dart';
import 'question.dart';
import 'package:provider/provider.dart';

class Notepad extends StatelessWidget {
  const Notepad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildWordChip(String word) {
      return Chip(
        label: Text(word),
      );
    }

    var something = context.read<DataStore>().getNext();

    const Widget dd = DdTextField(
        text:
            'Ik stond buiten in de frisse lucht, mijn blik ging omhoog naar de hemel en ik vroeg me af hoe mijn dag zou worden.');
    var words = ['ijsje', 'metro', 'werkplek', 'collega', 'uitlaatgassen'];
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
