import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/providers/dark_theme_provider.dart';
import 'package:shoes_app/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigationToOnboardScreen(context);
  }

  //method to navigate to onboard screen
  void navigationToOnboardScreen(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnBoardingScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: themeState.getDarkTheme
            ? const Color(0xFF000000)
            : const Color(0xfffef9f3),
        child: Center(
          child: Image.asset(
            'assets/images/nike_logo.png',
            height: 100,
            width: 100,
          ),
        ),
      ),
    );
  }
}
