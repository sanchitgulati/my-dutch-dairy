import 'package:flutter/material.dart';
import 'horizontal_week_calendar.dart';
import 'package:intl/intl.dart';
import 'dd_text_field.dart';
import 'question.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _HorizontalWeekCalendarPackageState();
}

class _HorizontalWeekCalendarPackageState extends State<Calender> {
  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    Widget selectedDateWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 5),
        Text(
          DateFormat('dd MMM yyyy').format(selectedDate),
          textAlign: TextAlign.center,
          style: theme.textTheme.titleLarge!.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ],
    );

    Widget textSection = const Question();

    Widget listView = ListView(children: [
      selectedDateWidget,
      textSection,
      DdTextField(title: 'How did you start your morning?'),
    ]);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // This line removes the back button
        title: const Text(
          "Schrijven",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              HorizontalWeekCalendar(
                // weekStartFrom: WeekStartFrom.monday,
                // activeBackgroundColor: Colors.purple,
                // activeTextColor: Colors.white,
                // inactiveBackgroundColor: Colors.purple.withOpacity(.3),
                // inactiveTextColor: Colors.white,
                // disabledTextColor: Colors.grey,
                // disabledBackgroundColor: Colors.grey.withOpacity(.3),
                // activeNavigatorColor: Colors.purple,
                // inactiveNavigatorColor: Colors.grey,
                // monthColor: Colors.purple,
                onDateChange: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),
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
