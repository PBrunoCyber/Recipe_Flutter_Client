import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/models/recipe.dart';
import 'package:food_recipe/views/recipe_details.dart';
import 'package:food_recipe/views/widgets/recipe_card.dart';
import 'package:food_recipe/controllers/recipe.api.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe> recipes;
  bool _isLoading = true;

  Future<void> getRecipes() async {
    recipes = await RecipeApi.getRecipes();
    setState(() {
      _isLoading = false;
    });
    print(recipes.length);
  }

  @override
  void initState() {
    getRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.restaurant_menu_outlined),
            SizedBox(width: 5),
            Text("Food Recipe"),
          ],
        ),
      ),
      body: _isLoading
          ? const CupertinoActivityIndicator()
          : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          RecipeDetails(recipe: recipes[index]),
                    ),
                  ),
                  child: RecipeCard(
                    name: recipes[index].name,
                    totalTime: recipes[index].totalTime,
                    rating: recipes[index].rating,
                    image: recipes[index].image,
                  ),
                );
              },
            ),
    );
  }
}
