import 'package:flutter/material.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeCalendar extends StatelessWidget {
  const HomeCalendar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border(
          bottom: BorderSide(
            color: Colors.black, // Brutalistic bold black border
            width: 4.0, // Thick bottom border
          ),
          right: BorderSide(
            color: Colors.black, // Thick right border
            width: 4.0,
          ),
          left: BorderSide(color: TColors.black, width: 1.0),
          top: BorderSide(color: TColors.black, width: 1.0),
        ),
      ),
      child: TableCalendar(
        calendarStyle: const CalendarStyle(
            todayDecoration: BoxDecoration(color: TColors.buttonPrimary)),
        firstDay: DateTime.utc(2023, 01, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
      ),
    );
  }
}
