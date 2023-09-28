import 'package:diary_app/data_store.dart';
import 'package:diary_app/selected_date.dart';
import 'package:flutter/material.dart';
import 'horizontal_week_calendar.dart';
import 'dd_text_field.dart';
import 'question.dart';
import 'package:provider/provider.dart';

class Calendar extends StatelessWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget textSection =
        Question(q: context.read<DataStore>().selectedQuestion);

    Widget dd = DdTextField();

    Widget listView = ListView(children: [
      const SelectedDateWidget(),
      textSection,
      TextButton(
        onPressed: context.read<DataStore>().onRefresh,
        child: const Text('Refresh'),
      ),
      dd,
      Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                context.read<DataStore>().save();
              },
              child: const Text('Save'),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                context.read<DataStore>().clearStorage();
              },
              child: const Text('Clear storage'),
            ),
          ),
        ],
      )
    ]);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // This line removes the back button;
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              HorizontalWeekCalendar(
                  weekStartFrom: WeekStartFrom.monday,
                  activeBackgroundColor: Colors.purple,
                  activeTextColor: Colors.white,
                  inactiveBackgroundColor: Colors.purple.withOpacity(.3),
                  inactiveTextColor: Colors.white,
                  disabledTextColor: Colors.grey,
                  disabledBackgroundColor: Colors.grey.withOpacity(.3),
                  activeNavigatorColor: Colors.purple,
                  inactiveNavigatorColor: Colors.grey,
                  monthColor: Colors.purple,
                  onDateChange: context.watch<DataStore>().onDateChange),
              Expanded(
                child: listView,
              )
            ],
          ),
        ),
      ),
    );
  }
}
