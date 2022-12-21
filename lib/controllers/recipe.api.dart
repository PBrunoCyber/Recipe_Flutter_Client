import 'dart:convert';
import 'package:food_recipe/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
  static Future<List<Recipe>> getRecipes() async {
    var uri = Uri.https(
        'yummly2.p.rapidapi.com', '/feeds/list', {'limit': '2', 'start': '3'});

    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'fcacbf1298msh1e4f149e2484aaap18561ejsn45738c4709c0',
      'X-RapidAPI-Host': 'yummly2.p.rapidapi.com'
    });

    Map data = jsonDecode(response.body);
    List temp = [];

    for (var i in data['feed']) {
      temp.add(i['content']['details']);
    }

    return Recipe.recipeFromSnapShot(temp);
  }
}
