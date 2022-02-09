import 'package:flutter/material.dart';
import 'package:recipe_app/view/FooderlichTheme.dart';
import 'package:recipe_app/view/screens/cards/card1.dart';
import 'package:recipe_app/view/screens/cards/card2.dart';
import 'package:recipe_app/view/screens/cards/card3.dart';
// import 'package:recipe_app/view/screens/home_screen.dart';
class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  int _selectedIndex = 0;

  static List<Widget> pages = <Widget>[
    const Card1(),
    const Card2(),
    const Card3(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Fooderlich',
            style: FooderlichTheme.darkTextTheme.headline6,
          ),
        ),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.card_giftcard,
              ),
              label: 'Card',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.card_giftcard,
              ),
              label: 'Author',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.card_giftcard,
              ),
              label: 'Trends',
          ),
        ],
      ),
    );
  }
}
