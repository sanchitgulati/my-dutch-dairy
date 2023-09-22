import 'package:flutter/material.dart';
import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<StatefulWidget> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return HorizontalWeekCalendar(
      onDateChange: (date) {
        setState(() {
          selectedDate = date;
        });
      },
    );
  }
}
