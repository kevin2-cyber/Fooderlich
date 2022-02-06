import 'package:flutter/material.dart';
import 'package:recipe_app/home_screen.dart';
class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Home(),
              ),
          );
        },
        child: const Icon(
          Icons.arrow_forward_ios,
        ),
      ),
    );
  }
}
