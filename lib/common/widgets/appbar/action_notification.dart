import 'package:flutter/material.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';

class ActionNotification extends StatelessWidget {
  const ActionNotification({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Iconsax.notification),
          onPressed: () {},
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: TColors.black,
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Center(
              child: Text(
                '2',
                style: TextStyle(color: TColors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
