import 'package:flutter/material.dart';
import 'package:mobile/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/device/device_utility.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingDotNavigation extends StatelessWidget {
  const OnboardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;

    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: TSizes.defaultSpace,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        effect: const ExpandingDotsEffect(
            activeDotColor: TColors.primaryColor, dotHeight: 6),
        count: 2,
      ),
    );
  }
}
