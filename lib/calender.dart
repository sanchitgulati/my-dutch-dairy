import 'package:flutter/material.dart';
import 'horizontal_week_calendar.dart';
import 'package:intl/intl.dart';
import 'dd_text_field.dart';

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

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: const Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
        'Alps. Situated 1,578 meters above sea level, it is one of the '
        'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
        'half-hour walk through pastures and pine forest, leads you to the '
        'lake, which warms to 20 degrees Celsius in the summer. Activities '
        'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    );

    Widget listView = ListView(children: [
      Image.asset(
        'assets/images/lake.jpg',
        width: 600,
        height: 240,
        fit: BoxFit.cover,
      ),
      selectedDateWidget,
      textSection,
      const DdTextField(title: 'How did you start your morning?'),
    ]);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // This line removes the back button
        title: const Text(
          "Horizontal Week Calendar",
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
