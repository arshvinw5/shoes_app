import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/providers/dark_theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Container(
      child: Center(
        child: SwitchListTile(
            title: Text(
              'Theme',
              style: TextStyle(
                  color: themeState.getDarkTheme ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            secondary: Icon(themeState.getDarkTheme
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined),
            value: themeState.getDarkTheme,
            onChanged: (bool value) {
              themeState.setDarkTheme = value;
            }),
      ),
    );
  }
}
