import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/features/authentication/screens/login/login.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/image_strings.dart';
import 'package:mobile/utils/constants/sizes.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => const LoginScreen()),
            icon: const Icon(Iconsax.close_circle),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Images
              const Image(image: AssetImage(TImages.verifyEmailImage)),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Title & Sub Title
              const Text(
                'Verify your email address!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: TSizes.fontSize2Xl,
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              const Text(
                'Congratulations! Your Account Awaits: Verify Your Email to Start Exploring E-CDM and Experience Features for You.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: TSizes.fontSizeSm,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Buttons
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.buttonPrimary,
                      foregroundColor: TColors.white,
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black, // Border color
                          width: 2, // Border thickness
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ), // Square edges for a brutalist look
                      ),
                    ),
                    onPressed: () => Get.to(const LoginScreen()),
                    child: const Text(
                      'Login Now',
                      style: TextStyle(
                        fontSize: TSizes.fontSizeMd,
                      ),
                    )),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Resend Email',
                    style: TextStyle(color: TColors.primaryColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
