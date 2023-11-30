
import 'dart:ffi';

import 'package:spoonacular_app/models/ingredient.dart';


class Results {
  List<Recipe> recipes;

  Results({required this.recipes});

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      recipes: List<Recipe>.from(json['results'].map((x) => Recipe.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
    'results': List<dynamic>.from(recipes.map((x) => x.toJson())),
    };
  }

}


class Recipe {
  int id;
  String title;
  String image;
  String imageType;
  String? summary;
  int? servings;
  int? readyInMinutes;
  Float? healthScore;
  Float? spoonacularScore;
  Float? pricePerServing;
  List<Ingredient>? ingredients;

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.imageType,
    this.summary,
    this.servings,
    this.readyInMinutes,
    this.healthScore,
    this.spoonacularScore,
    this.pricePerServing,
    this.ingredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    id : json['id'],
    title : json['title'],
    image : json['image'],
    imageType : json['imageType'],
    summary : json['summary'] != null ? json['summary'] : null,
    servings : json['servings']!= null? json['servings'] : null,
    readyInMinutes : json['readyInMinutes']!= null? json['readyInMinutes'] : null,
    healthScore : json['healthScore']!= null? json['healthScore'] : null,
    spoonacularScore : json['spoonacularScore']!= null? json['spoonacularScore'] : null,
    pricePerServing : json['pricePerServing']!= null? json['pricePerServing'] : null,
    ingredients : json['ingredients']!= null? List<Ingredient>.from(json['ingredients'].map((x) => Ingredient.fromJson(x))) : null,
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'imageType': imageType,
      if (summary!= null)'summary': summary,
      if (servings!= null)'servings': servings,
      if (readyInMinutes!= null)'readyInMinutes': readyInMinutes,
      if (healthScore!= null) 'healthScore': healthScore,
      if (spoonacularScore!= null)'spoonacularScore': spoonacularScore,
      if (pricePerServing!= null) 'pricePerServing': pricePerServing,
      if (ingredients!= null) 'ingredients': List<dynamic>.from(ingredients!.map((x) => x.toJson())),
    };
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'image': image, 'imageType': imageType};
  }

  Recipe.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        id = map['id'],
        image = map['image'],
        imageType = map['imageType'];


}
