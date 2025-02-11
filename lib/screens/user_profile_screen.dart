import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/model/User.dart';
import 'package:shoes_app/providers/dark_theme_provider.dart';

class UserProfileScreen extends StatefulWidget {
  //since we are inheriting from parent class StatefulWidget
  User user;
  UserProfileScreen({super.key, required this.user});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context).getDarkTheme;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Center(
                child: ClipRRect(
                    child: Image.network(
                  widget.user.imageUrl ?? '',
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                )),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              child: Center(
                child: Text(
                  '${widget.user.firstName ?? ''} ${widget.user.lastName ?? ''}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            Container(
              child: Center(
                child: Text(
                  widget.user.address?.city ?? '',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
