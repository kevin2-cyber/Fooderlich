// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:recipe_app/fooderlich_theme.dart';
import '../models/models.dart';

class LoginScreen extends StatelessWidget {
  get rwColor => FooderlichTheme.rwColor;

  // LoginScreen MaterialPage Helper
  static MaterialPage page() {
    return MaterialPage(
      name: FooderlichPages.loginPath,
      key: ValueKey(FooderlichPages.loginPath),
      child: const LoginScreen(),
    );
  }

  final String? username;

  const LoginScreen({
    Key? key,
    this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 200,
                child: Image(
                  image: AssetImage(
                    'assets/fooderlich_assets/rw_logo.png',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              buildTextField(username ?? '🍔 username'),
              const SizedBox(height: 16),
              buildTextField('🎹 password'),
              const SizedBox(height: 16),
              buildButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    return SizedBox(
      height: 55,
      child: MaterialButton(
        color: rwColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          // Login -> Navigate to home
          Provider.of<AppStateManager>(context, listen: false)
              .login('mockUsername', 'mockPassword');
        },
      ),
    );
  }

  Widget buildTextField(String hintText) {
    return TextField(
      cursorColor: rwColor,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          borderSide: BorderSide(
            color: Colors.green,
            width: 1.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(height: 0.5),
      ),
    );
  }
}
