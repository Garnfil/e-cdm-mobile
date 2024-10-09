import 'package:flutter/material.dart';
import 'package:mobile/features/authentication/screens/register/widgets/register_form.dart';
import 'package:mobile/features/authentication/screens/register/widgets/register_header.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: TColors.primaryBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: TSizes.appBarHeight,
            left: TSizes.defaultSpace,
            bottom: TSizes.defaultSpace,
            right: TSizes.defaultSpace,
          ),
          child: Column(
            children: [
              // Header
              RegisterHeader(),
              SizedBox(height: 20),
              // Form
              RegisterForm()
            ],
          ),
        ),
      ),
    );
  }
}
