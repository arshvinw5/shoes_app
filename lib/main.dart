import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/consts/theme_data.dart';
import 'package:shoes_app/providers/dark_theme_provider.dart';
import 'package:shoes_app/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  //made an obj
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  //function to fetch the vlaue from user phone memory
  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.drakThemePref.getTheme();

    //getTheme return currrent vlaue then its set to setDarkTheme method in provider as a inistal value

    //When getCurrentAppTheme() is called during initState,
    //it ensures that the app starts with the c
    //orrect theme (dark or light) based on the user's
    //previously saved preference.

    // The theme change provider (DarkThemeProvider) keeps the theme
    // state synchronized with the shared preferences storage.
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        })
      ],
      child:
          Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Shoes App',
          debugShowCheckedModeBanner: false,
          theme: Styles.themeData(themeProvider.getDarkTheme, context),
          home: const SplashScreen(),
        );
      }),
    );
  }
}



// In Flutter, the Consumer widget is 
//provided by the provider package and is used to listen to changes in a specific part of your 
//app's state managed by a ChangeNotifier. It rebuilds only the widgets that need to react to 
//state changes, optimizing performance and keeping your UI responsive.


