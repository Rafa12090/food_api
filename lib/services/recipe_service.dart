import 'dart:convert';
import 'dart:io';

import 'package:spoonacular_app/models/ingredient.dart';
import 'package:spoonacular_app/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeService {
  final _baseUrl = 'https://api.spoonacular.com/recipes/';
  final _apiKey = '?apiKey=32f94c5a502842a8b84db8b9f4deb0b1';
  final _query = '&query=';
  final _includeNutrition = '&includeNutrition=false';

  Future<List<Recipe>> searchRecipes(String endpoint, String query) async {
    http.Response response =
        await http.get(Uri.parse('$_baseUrl$endpoint$_apiKey$_query$query'));
    if (response.statusCode == HttpStatus.ok) {
      final dynamic jsonResponse = json.decode(response.body);
      if (jsonResponse is Map && jsonResponse.containsKey('results')) {
        final List<dynamic> recipeList = jsonResponse['results'];
        return recipeList.map((recipe) => Recipe.fromJson(recipe)).toList();
      } else {
        return [];
      }
    }
    return [];
  }

  setSummaryRecipe(Recipe recipe, String endpoint, int id) async {
    if (recipe.id == id) {
      http.Response response =
          await http.get(Uri.parse('$_baseUrl$id/$endpoint$_apiKey'));
      if (response.statusCode == HttpStatus.ok) {
        final dynamic jsonResponse = json.decode(response.body);
        recipe.summary = jsonResponse['summary'];
      }
    }
  }

  setIngredientsRecipe(Recipe recipe, String endpoint, int id) async {
    if (recipe.id == id) {
      http.Response response =
          await http.get(Uri.parse('$_baseUrl$id/$endpoint$_apiKey'));
      if (response.statusCode == HttpStatus.ok) {
        final dynamic jsonResponse = json.decode(response.body);
        if (jsonResponse is Map && jsonResponse.containsKey('ingredients')) {
          final List<dynamic> ingredientsList = jsonResponse['ingredients'];
          recipe.ingredients = ingredientsList.map((ingredient) => Ingredient.fromJson(ingredient)).toList();
        }
      }
    }
  }

  setInformationRecipe(Recipe recipe, String endpoint, int id) async {
    if (recipe.id == id) {
      http.Response response =
          await http.get(Uri.parse('$_baseUrl$id/$endpoint$_apiKey$_includeNutrition'));
      if (response.statusCode == HttpStatus.ok) {
        final dynamic jsonResponse = json.decode(response.body);
        recipe.summary = jsonResponse['summary'];
        recipe.servings = jsonResponse['servings'];
        recipe.readyInMinutes = jsonResponse['readyInMinutes'];
        recipe.image = jsonResponse['image'];
        recipe.healthScore = jsonResponse['healthScore'];
        recipe.spoonacularScore = jsonResponse['spoonacularScore'];
        recipe.pricePerServing = jsonResponse['pricePerServing'];
      }
    }
  }


}
