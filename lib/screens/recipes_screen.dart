// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../api/mock_fooderlich_service.dart';
import '../widgets/widgets.dart';
import '../models/models.dart';

class RecipesScreen extends StatelessWidget {
  final exploreService = MockFooderlichService();

  RecipesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: exploreService.getRecipes(),
      builder: (context, AsyncSnapshot<List<SimpleRecipe>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return RecipesGridView(recipes: snapshot.data ?? []);
          //return const Center(child: Text('Recipes Screen'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
