import 'package:flutter/material.dart';
import 'package:recipe_app/FooderlichTheme.dart';
import 'package:recipe_app/view/screens/home_screen.dart';
class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FooderlichTheme.kbgColor,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Home(),
              ),
          );
        },
        tooltip: 'Welcome',
        child: const Icon(
          Icons.arrow_forward_ios,
        ),
      ),
    );
  }
}
