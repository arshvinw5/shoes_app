import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/providers/dark_theme_provider.dart';
import 'package:shoes_app/screens/products.dart';
import 'package:shoes_app/screens/test_user_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SwitchListTile(
                  title: Text(
                    'Theme',
                    style: TextStyle(
                        color: themeState.getDarkTheme
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  secondary: Icon(themeState.getDarkTheme
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined),
                  value: themeState.getDarkTheme,
                  onChanged: (bool value) {
                    themeState.setDarkTheme = value;
                  }),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('View All Users'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TestUserScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.shop),
                title: const Text('Products'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductsScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
