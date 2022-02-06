import 'package:flutter/material.dart';
import 'package:recipe_app/view/screens/welcome_screen.dart';

void main() => runApp(const Fooderlich());


class Fooderlich extends StatelessWidget {
  const Fooderlich({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Welcome(),
    );
  }
}


