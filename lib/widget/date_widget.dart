
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({
    Key? key,
    required DateTime selectedDate,
  })  : _selectedDate = selectedDate,
        super(key: key);

  final DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Chip(
            // backgroundColor: kPrimaryColor.withOpacity(0.2),
            label: Text(
              DateFormat('EEEEE', 'en_US').format(_selectedDate),
            ),
            labelPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
          ),
          const SizedBox(width: 6),
          Text(DateFormat.yMMMMd().format(_selectedDate)),
        ],
      ),
    );
  }
}
