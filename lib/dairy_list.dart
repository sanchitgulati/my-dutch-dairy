import 'package:diary_app/data_store.dart';
import 'package:diary_app/journal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DiaryList extends StatelessWidget {
  const DiaryList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Journal>>(
      future: context.read<DataStore>().getDataFromDatabase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data?.isEmpty == true) {
          return Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<DataStore>().newStory();
                Navigator.of(context).pushNamed('/notepad');
              },
              child: const Text('Write your first story'),
            ),
          );
        } else {
          return ListView.separated(
            itemCount: snapshot.data!.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final row = snapshot.data![index];
              final dateTime = DateTime.fromMillisecondsSinceEpoch(
                  row.millisecondsSinceEpoch);
              final formattedBlockDate = DateFormat('EEEE, MMMM d')
                  .format(dateTime); // Format the date
              final blockHeading = row.heading;
              final blockText = row.text;

              return Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                // decoration: BoxDecoration(
                //   border: Border.all(
                //     color: Colors.grey,
                //     width: 1.0,
                //   ),
                //   borderRadius: BorderRadius.circular(8.0),
                // ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formattedBlockDate,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Text(
                    //   blockHeading,
                    //   style: const TextStyle(
                    //     fontSize: 18.0,
                    //   ),
                    // ),
                    Text(
                      blockText,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    OutlinedButton(
                        onPressed: () => {
                              _confirm(context, row.id ?? ""),
                            },
                        child: const Text('Delete')),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  Future<bool> _confirm(BuildContext context, id) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Deleting the story'),
            actions: <Widget>[
              TextButton(
                onPressed: () => {Navigator.pop(context)},
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  context.read<DataStore>().delete(id);
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/home');
                },
                child: const Text('Confirm'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
