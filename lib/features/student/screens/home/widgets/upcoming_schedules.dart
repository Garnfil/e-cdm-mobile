import 'package:flutter/material.dart';
import 'package:mobile/features/student/screens/home/widgets/schedule_card.dart';
import 'package:mobile/utils/constants/sizes.dart';

class UpcomingSchedulesList extends StatelessWidget {
  const UpcomingSchedulesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        Text(
          'Upcoming Schedules',
          style: TextStyle(
            fontSize: TSizes.fontSizeXl,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: TSizes.defaultSpace),

        /// Upcoming Schedules
        SizedBox(
          child: Column(
            children: [
              ScheduleCard(
                date: '14',
                month: 'NOV',
                time: '10:00 A.M',
                day: 'Friday',
                mode: 'Face to Face',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
