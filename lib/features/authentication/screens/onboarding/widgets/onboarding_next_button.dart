import 'package:flutter/material.dart';
import 'package:mobile/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/device/device_utility.dart';
import 'package:iconsax/iconsax.dart';

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: TSizes.defaultSpace,
      bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => OnboardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: TColors.buttonPrimary,
        ),
        child: const Icon(
          Iconsax.arrow_right_3,
          color: TColors.white,
        ),
      ),
    );
  }
}
