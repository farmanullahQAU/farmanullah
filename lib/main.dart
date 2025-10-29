import 'package:farmanullah/controllers/theme_controller.dart';
import 'package:farmanullah/utils/constants.dart';
import 'package:farmanullah/views/home_page.dart';
import 'package:farmanullah/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations for better UX
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

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
      home: SplashScreen(child: const HomePage()),
    );
  }
}
