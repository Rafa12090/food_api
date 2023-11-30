import 'package:flutter/material.dart';
import 'package:spoonacular_app/services/recipe_service.dart';
import 'package:spoonacular_app/widgets/recipe_list.dart';

class RecipeSearch extends StatefulWidget {
  const RecipeSearch({super.key});

  @override
  State<RecipeSearch> createState() => _RecipeSearchState();
}

class _RecipeSearchState extends State<RecipeSearch> {

  List recipes = [];

  final searchController = TextEditingController();

  initialize() async {
    recipes = await RecipeService().searchRecipes('complexSearch', 'pastas');
    setState(() {
      recipes = recipes;
    });
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void searchRecipes(String value) async {
    recipes = await RecipeService().searchRecipes('complexSearch', value);
    setState(() {
      recipes = recipes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          decoration: const InputDecoration(
            hintText: 'Search recipes',
            hintStyle: TextStyle(
              color: Colors.white54,
              fontWeight: FontWeight.bold,
            ),
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
            ),
            prefixIconColor: Colors.white54
          ),
          onSubmitted: searchRecipes,
        ),
      ),
      body: RecipeList(recipes: recipes),
    );
  }
}