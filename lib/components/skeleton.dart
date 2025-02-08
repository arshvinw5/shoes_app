import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/providers/dark_theme_provider.dart';

class Skeleton extends StatelessWidget {
  final double? height, width;
  const Skeleton({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context).getDarkTheme;
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: themeState ? Colors.white12 : Colors.black26,
          borderRadius: const BorderRadius.all(Radius.circular(16.0))),
    );
  }
}
