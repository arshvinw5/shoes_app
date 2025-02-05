import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/components/reuseable_button.dart';
import 'package:shoes_app/providers/dark_theme_provider.dart';
import 'package:shoes_app/screens/settings_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context).getDarkTheme;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //
            themeState
                ? Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Image.asset(
                      'assets/images/nike_white_logo.png',
                      height: 300,
                      width: 300,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Image.asset(
                      'assets/images/nike_logo.png',
                      height: 300,
                      width: 300,
                    ),
                  ),

            const SizedBox(
              height: 10,
            ),
            //title
            Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Find the best shoe for you',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.bebasNeue(
                            fontSize: 56.0,
                            fontWeight: FontWeight.bold,
                            color: themeState
                                ? const Color(0xfffef9f3)
                                : const Color(0xFF000000)),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        'The best time to savor is now. Take a moment to explore the world of best shoes with us.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color:
                                themeState ? Colors.grey[700] : Colors.black45,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
            //sub title
            const SizedBox(
              height: 10.0,
            ),
            //button
            ReuseableButton(
              text: 'Shop now',
              fontSize: 16.0,
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsScreen())),
            )
          ],
        ),
      ),
    );
  }
}
