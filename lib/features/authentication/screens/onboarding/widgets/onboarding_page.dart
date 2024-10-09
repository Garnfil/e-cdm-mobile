import 'package:flutter/material.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/helpers/helper_functions.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          Image(
            image: AssetImage(image),
            width: THelperFunction.screenWidth() * 0.8,
            height: THelperFunction.screenHeight() * 0.6,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 35),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Text(
            subTitle,
            style: const TextStyle(fontSize: TSizes.fontSizeSm),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
