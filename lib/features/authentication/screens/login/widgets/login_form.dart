import 'package:flutter/material.dart';
import 'package:mobile/navigation_menu.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/features/authentication/screens/register/register.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
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
          const SizedBox(
            height: 20,
          ),

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
          const SizedBox(
            height: 10,
          ),

          /// Remember Me & Forgot Password
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              /// Forgot Password
              TextButton(onPressed: () {}, child: const Text('Forgot Password'))
            ],
          ),

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
                onPressed: () => Get.to(() => const NavigationMenu()),
                child: const Text(
                  'Sign In',
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
                onPressed: () => Get.to(const RegisterScreen()),
                child: const Text(
                  'Register as Student',
                  style: TextStyle(
                      fontSize: TSizes.fontSizeMd, color: TColors.textPrimary),
                )),
          ),
        ],
      ),
    ));
  }
}
