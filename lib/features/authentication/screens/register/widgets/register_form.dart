import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/features/authentication/screens/login/login.dart';
import 'package:mobile/features/authentication/screens/register/verify_email.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
      child: Column(
        children: [
          /// Student ID
          TextFormField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: TColors.black,
                    width: 2,
                  ),
                ),
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: "Student ID"),
          ),
          const SizedBox(
            height: 20,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: TColors.black,
                          width: 2,
                        ),
                      ),
                      prefixIcon: Icon(Iconsax.direct_right),
                      labelText: "First Name"),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: TColors.black,
                          width: 2,
                        ),
                      ),
                      prefixIcon: Icon(Iconsax.direct_right),
                      labelText: "Last Name"),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// Email
          TextFormField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: TColors.black,
                    width: 2,
                  ),
                ),
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: "Email"),
          ),
          const SizedBox(height: 20),

          /// Password
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: TColors.black,
                  width: 2,
                ),
              ),
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: "Password",
              suffixIcon: Icon(Iconsax.eye_slash),
            ),
          ),
          const SizedBox(height: 10),

          // Sign In Button
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
                onPressed: () => Get.to(const VerifyEmailScreen()),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: TSizes.fontSizeMd,
                  ),
                )),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          /// Create Account Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: TColors.black,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.black, // Border color
                      width: 3, // Border thickness
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ), // Square edges for a brutalist look
                  ),
                ),
                onPressed: () => Get.to(const LoginScreen()),
                child: const Text(
                  'Login',
                  style: TextStyle(
                      fontSize: TSizes.fontSizeMd, color: TColors.textPrimary),
                )),
          ),
        ],
      ),
    ));
  }
}
