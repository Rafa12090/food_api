import 'package:flutter/material.dart';
import 'package:spoonacular_app/models/recipe.dart';
import 'package:spoonacular_app/repositories/recipe_repository.dart';
import 'package:spoonacular_app/screens/recipe_detail.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({super.key, required this.recipes});

  final List recipes;

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: widget.recipes.length,
        itemBuilder: (context, index) {
          return RecipeItem(recipe: widget.recipes[index]);
        });
  }
}

class RecipeItem extends StatefulWidget {
  const RecipeItem({super.key, required this.recipe});

  final Recipe recipe;

  @override
  State<RecipeItem> createState() => _RecipeItemState();
}

class _RecipeItemState extends State<RecipeItem> {
  bool isFavorite = false;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    isFavorite = await RecipeRepository().isFavorite(widget.recipe);
    if (mounted) {
      setState(() {
        isFavorite = isFavorite;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final icon =
        Icon(Icons.favorite, color: isFavorite ? Colors.red : Colors.grey);
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RecipeDetail(recipe: widget.recipe))),
      child: SafeArea(
        child: Card(
          elevation: 2,
          child: Column(
            children: [
              SizedBox(
                height: 150,
                child: Stack(
                  children: [
                    Image.network(widget.recipe.image, fit: BoxFit.fill),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                          isFavorite
                              ? RecipeRepository().insert(widget.recipe)
                              : RecipeRepository().delete(widget.recipe.id);
                        },
                        icon: icon,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RecipeDetail(recipe: widget.recipe)));
                        },
                        icon: const Icon(Icons.info),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                widget.recipe.title,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
