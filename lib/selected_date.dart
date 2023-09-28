import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'data_store.dart';
import 'package:provider/provider.dart';

class SelectedDateWidget extends StatelessWidget {
  const SelectedDateWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 5),
        Text(
          DateFormat('dd MMM yyyy')
              .format(context.read<DataStore>().selectedDate),
          textAlign: TextAlign.center,
          style: theme.textTheme.titleLarge!.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ],
    );
  }
}
