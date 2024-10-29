import 'package:flutter/material.dart';
import 'package:mobile/features/authentication/screens/login/widgets/login_form.dart';
import 'package:mobile/features/authentication/screens/login/widgets/login_header.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.primaryBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: TSizes.appBarHeight,
            left: TSizes.defaultSpace,
            bottom: TSizes.defaultSpace,
            right: TSizes.defaultSpace,
          ),
          child: Column(
            children: [
              /// Header
              const LoginHeader(),

              /// Form
              LoginForm()
            ],
          ),
        ),
      ),
    );
  }
}
