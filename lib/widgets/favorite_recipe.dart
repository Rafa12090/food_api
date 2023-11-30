import 'package:flutter/material.dart';
import 'package:spoonacular_app/models/recipe.dart';
import 'package:spoonacular_app/repositories/recipe_repository.dart';

class FavoriteRecipes extends StatefulWidget {
  const FavoriteRecipes({super.key});

  @override
  State<FavoriteRecipes> createState() => _FavoriteRecipesState();
}

class _FavoriteRecipesState extends State<FavoriteRecipes> {
  RecipeRepository? _recipeRepository;
  List<Recipe>? _recipes;
  int? _numberOfElements;

  initialize() async {
    _recipes = await _recipeRepository?.getAll() ?? [];
    _numberOfElements = await _recipeRepository?.getCount();
    setState(() {
      _recipes = _recipes;
      _numberOfElements = _numberOfElements;
    });
  }

  @override
  void initState() {
    _recipeRepository = RecipeRepository();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Número de elementos en la base de datos: ${_numberOfElements ?? 0}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      _numberOfElements == 0
          ? const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("No hay elementos en la base de datos."),
            )
          : Expanded(
              child: ListView.builder(
                  itemCount: _recipes?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_recipes?[index].title ?? ""),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(_recipes?[index].image ?? ""),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _recipeRepository
                                  ?.delete(_recipes?[index].id ?? 0);
                              initialize();
                            },
                            child: const Text("Delete"),
                          ),
                        ),
                      ]),
                    );
                  }))
    ]);
  }
}
