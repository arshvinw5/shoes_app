import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/providers/dark_theme_provider.dart';

class ReuseableButton extends StatelessWidget {
  final String text;
  final double? fontSize;
  final void Function()? onTap;

  const ReuseableButton(
      {super.key, required this.text, this.fontSize, this.onTap});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
        child: Container(
          decoration: BoxDecoration(
            color: themeState.getDarkTheme
                ? const Color(0xfffef9f3)
                : const Color(0xFF000000),
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: Text(text,
                style: TextStyle(
                    color: themeState.getDarkTheme
                        ? const Color(0xff000000)
                        : const Color(0xffffffff),
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}

class float {}
