import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/ui/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen.navigate(
        name: 'assets/splashIntro.flr',
        next: (context) => HomePage(),
        until: () => Future.delayed(Duration(seconds: 5)),
        startAnimation: 'intro',
      ),
      // home: HomePage(),
    );
  }
}
