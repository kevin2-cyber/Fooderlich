import 'package:flutter/material.dart';


class Card2 extends StatelessWidget {
  const Card2({Key? key}) : super(key: key);

  final String category = 'Editor\'s choice';
  final String title = 'The Art of Dough';
  final String description = 'Learn to make the perfect bread';
  final String chef = 'Ray Wenderlich';

  @override
  Widget build(BuildContext context) {
    return Center(
      //TODO: Card1 decorate container
      child: Container(
        color: Colors.yellow,
      ),
    );
  }
}
