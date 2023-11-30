import 'package:flutter/material.dart';
import 'package:spoonacular_app/models/recipe.dart';
import 'package:spoonacular_app/repositories/recipe_repository.dart';


class RecipeDetail extends StatefulWidget {
  const RecipeDetail({super.key, required this.recipe});
  final Recipe recipe;

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {

  bool _favorite = false;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  Future initialize() async {
    _favorite = await RecipeRepository().isFavorite(widget.recipe);
    if(mounted){
      setState(() {
        _favorite = _favorite;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final icon =
        Icon(Icons.favorite, color: _favorite ? Colors.red : Colors.grey);

    final image = widget.recipe.image;

    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(widget.recipe.title),
                      background: Image.network(
                        image,
                        fit: BoxFit.cover,
                      )),
                )
              ];
            },
            body: Column(
              children: [
                IconButton(
                    onPressed: () {
                      if (mounted) {
                        setState(() {
                          _favorite = !_favorite;
                        });
                      }

                      _favorite
                          ? RecipeRepository()
                              .insert(widget.recipe)
                          : RecipeRepository()
                              .delete(widget.recipe.id);
                    },
                    icon: icon),
                Card(
                    child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.recipe.title,
                          style: const TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold))),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      widget.recipe.id.toString(),
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold))),
                ])),
              ],
            )));
  }
}