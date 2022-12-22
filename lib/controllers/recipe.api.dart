import 'package:food_recipe/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
  static Future<List<Recipe>> getRecipes() async {
    var uri = Uri.http('192.168.1.8:8080', '/api/recipe');
    final response = await http.get(uri);
    return Recipe.parseRecipes(response.body);
  }
}
