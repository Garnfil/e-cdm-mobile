import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/features/student/screens/school_works/school_work.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/formatters/formatter.dart';

class SchoolWorkCard extends StatelessWidget {
  final int schoolWorkId;
  final String title;
  final String dueDate;
  final String schoolWorkType;

  const SchoolWorkCard({
    super.key,
    required this.title,
    required this.dueDate,
    required this.schoolWorkType,
    required this.schoolWorkId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => SchoolWorkDetailScreen(
            schoolWorkId: schoolWorkId,
          )),
      child: Card(
        margin: const EdgeInsets.all(10),
        elevation: 3,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// School Work Details (Left Side)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Due: ${TFormatter.formatDate(DateTime.parse(dueDate), 'dd/MMM/yy h:m a')}',
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                width: 20,
              ),

              /// School Work Type Badge (Right Side)
              Chip(
                label: Text(
                  schoolWorkType.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: const Color(0xffFFC900),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: const BorderSide(color: Colors.black, width: 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
