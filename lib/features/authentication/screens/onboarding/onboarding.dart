import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:mobile/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:mobile/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:mobile/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:mobile/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/image_strings.dart';
import 'package:mobile/utils/constants/text_strings.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      backgroundColor: TColors.white,
      body: Stack(
        children: [
          /// Horizontal Scrollable Pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnboardingPage(
                image: TImages.onBoardingImage1,
                title: TText.onboardingTitle1,
                subTitle: TText.onboardingSubTitle1,
              ),
              OnboardingPage(
                image: TImages.onBoardingImage2,
                title: TText.onboardingTitle2,
                subTitle: TText.onboardingSubTitle2,
              ),
            ],
          ),

          /// Skip Button
          const OnboardingSkip(),

          /// Dot Navigation SmoothPage Indicator
          const OnboardingDotNavigation(),

          /// Circular Button
          const OnboardingNextButton()
        ],
      ),
    );
  }
}
