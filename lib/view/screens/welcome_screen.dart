import 'package:flutter/material.dart';
import 'package:recipe_app/FooderlichTheme.dart';
import 'package:recipe_app/view/screens/home_screen.dart';
class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fooderlich',
          style: FooderlichTheme.darkTextTheme.headline6,
        ),
      ),
      body: Center(
        child: Text(
          'Let\'s get cooking.',
          style: FooderlichTheme.darkTextTheme.headline1,
        ),
      ),
    );
  }
}
