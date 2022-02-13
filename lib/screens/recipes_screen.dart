import 'package:flutter/material.dart';

import '../api/mock_fooderlich_service.dart';
import '../components/components.dart';
import '../models/models.dart';

class RecipesScreen extends StatelessWidget {

  final exploreService = MockFooderlichService();

  RecipesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      // 3
      future: exploreService.getRecipes(),
      builder: (context, AsyncSnapshot<List<SimpleRecipe>>
      snapshot) {
        // 4
        if (snapshot.connectionState == ConnectionState.done)
        {
          return RecipesGridView(recipes: snapshot.data ?? []);
          // 5
          return const Center(child: Text('Recipes Screen'));
        } else {
          // 6
          return const Center(child:
          CircularProgressIndicator());
        }
      },
    );
  }
}
