import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import 'screens.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 6
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // TODO 11: Present GroceryItemScreen
          final manager = Provider.of<GroceryManager>(context, listen: false);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GroceryItemScreen(
                      onCreate: (item) {
                        manager.addItem(item);
                        Navigator.pop(context);
                      },
                      onUpdate: (item) {},
                  ),
              ),
          );
        },
      ),
      // 7
      body: buildGroceryScreen(),
    );
  }

  Widget buildGroceryScreen() {
    // 1
    return Consumer<GroceryManager>(
      // 2
      builder: (context, manager, child) {
        // 3
        if (manager.groceryItems.isNotEmpty) {
          // TODO 25: Add GroceryListScreen
          return GroceryListScreen(manager: manager);
        } else {
          // 4
          return const EmptyGroceryScreen();
        }
      },
    );
  }
}