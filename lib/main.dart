import 'package:h1d023047_tugas7/about_page.dart';
import 'package:h1d023047_tugas7/home_page.dart';
import 'package:h1d023047_tugas7/login_page.dart';
import 'package:h1d023047_tugas7/splash_page.dart';
import 'package:flutter/material.dart';

const String appTitle = 'NIM_Tugas7';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName: (_) => const SplashPage(),
        LoginPage.routeName: (_) => const LoginPage(),
        HomePage.routeName: (_) => const HomePage(),
        AboutPage.routeName: (_) => const AboutPage(),
      },
    );
  }
}
