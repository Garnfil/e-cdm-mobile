import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/features/authentication/screens/onboarding/onboarding.dart';
import 'package:mobile/utils/constants/colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: TColors.primaryColor),
        useMaterial3: true,
      ),
      home: const OnBoardingScreen(),
    );
  }
}
