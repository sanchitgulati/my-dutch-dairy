import 'package:diary_app/data_store.dart';
import 'package:diary_app/entities/story.dart';
import 'package:flutter/material.dart';
import 'dd_text_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

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
        }));
  }

  void _showAlert(BuildContext context) {
    showPlatformDialog(
      context: context,
      builder: (_) => BasicDialogAlert(
        title: const Text("Confirmation"),
        content: const Text(
            "Your Story has been saved. You can view it on the home page."),
        actions: <Widget>[
          BasicDialogAction(
            title: const Text("OK"),
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).popAndPushNamed('/');
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> _confirmDiscard(BuildContext context) {
    return showPlatformDialog(
      context: context,
      builder: (_) => BasicDialogAlert(
        title: const Text("Confirmation"),
        content: const Text(
            "Discard current story and go back to home page ? You can't undo this action."),
        actions: <Widget>[
          BasicDialogAction(
            title: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop(true);
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          BasicDialogAction(
            title: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          )
        ],
      ),
    );
  }

  void _showErrorAlert(BuildContext context, {String text = ""}) {
    showPlatformDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Error"),
        content: Text(text),
        actions: <Widget>[
          BasicDialogAction(
            title: const Text("OK"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return (await _confirmDiscard(context)) ?? false;
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
          if (context.read<DataStore>().save()) {
            _showAlert(context);
          } else {
            _showErrorAlert(context, text: "Please enter a valid story");
          }
        },
        child: const Text('Done'),
      ),
    ]);

    return WillPopScope(
      onWillPop: () async {
        return _onWillPop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Make a story'),
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
              _confirmDiscard(context);
            },
          ),
        ),
        body: SafeArea(
          child: Padding(padding: const EdgeInsets.all(10), child: listView),
        ),
      ),
    );
  }
}
