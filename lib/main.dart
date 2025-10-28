import 'package:farmanullah/controllers/theme_controller.dart';
import 'package:farmanullah/utils/constants.dart';
import 'package:farmanullah/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());

    return GetMaterialApp(
      title: 'Farman Ullah - Portfolio',
      debugShowCheckedModeBanner: false,
      themeMode: themeController.themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppConstants.primaryColor,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: AppConstants.lightBackground,
        cardColor: AppConstants.lightCard,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppConstants.primaryColor,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: AppConstants.darkBackground,
        cardColor: AppConstants.darkCard,
      ),
      home: const HomePage(),
    );
  }
}
