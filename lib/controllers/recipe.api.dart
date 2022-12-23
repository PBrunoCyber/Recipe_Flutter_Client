import 'dart:convert';

import 'package:food_recipe/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
  static Future<List<Recipe>> getRecipes() async {
    var uri = Uri.http('192.168.1.8:8080', '/api/recipe');
    final response = await http.get(uri);
    return Recipe.parseRecipes(response.body);
  }

  static Future<http.Response> addNewRecipe(Recipe recipe) async {
    var uri = Uri.http('192.168.1.8:8080', '/api/recipe');
    var response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(
        {
          'name': recipe.name,
          'totalTime': recipe.totalTime,
          'rating': recipe.rating,
          'description': recipe.description,
          'image': recipe.image
        },
      ),
    );
    return response;
  }
}
