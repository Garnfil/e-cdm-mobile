import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/features/authentication/screens/login/login.dart';
import 'package:mobile/navigation_menu.dart';
import 'package:mobile/utils/constants/colors.dart';

class App extends StatelessWidget {
  final bool hasSession;

  const App({super.key, required this.hasSession});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: TColors.primaryColor),
        useMaterial3: true,
      ),
      home: hasSession ? const NavigationMenu() : const LoginScreen(),
    );
  }
}
