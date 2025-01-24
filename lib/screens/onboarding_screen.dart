import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Padding(
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
                        'Find the best coffee for you',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.bebasNeue(
                            fontSize: 56.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5.0),
                      const Text(
                        'The best time to savor is now. Take a moment to explore the world of coffee with us.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black45,
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
          ],
        ),
      ),
    );
  }
}
