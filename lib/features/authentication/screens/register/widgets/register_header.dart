import 'package:flutter/material.dart';
import 'package:mobile/utils/constants/image_strings.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/constants/text_strings.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: AssetImage(TImages.logo),
          height: 140,
        ),
        SizedBox(height: 20),
        Text(
          TText.registerTitle,
          style: TextStyle(fontSize: TSizes.fontSize2Xl),
        ),
        Text(
          TText.registerSubTitle,
          style: TextStyle(fontSize: TSizes.fontSizeSm),
        ),
      ],
    );
  }
}
