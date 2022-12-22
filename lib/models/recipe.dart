import 'dart:convert';

class Recipe {
  final String name;
  final String totalTime;
  final String image;
  final double rating;
  final String description;

  Recipe(
      {this.name, this.totalTime, this.image, this.rating, this.description});

  factory Recipe.fromJson(dynamic json) {
    return Recipe(
        name: json['name'] as String,
        totalTime: json['totalTime'] as String,
        image: json['image'] as String,
        rating: json['rating'] as double,
        description: json['description'] as String);
  }

  static List<Recipe> parseRecipes(var responseBody) {
    final parsed = jsonDecode(responseBody);
    return parsed.map<Recipe>((json) => Recipe.fromJson(json)).toList();
  }

  @override
  String toString() {
    return 'Recipe{name: $name, totalTime: $totalTime, image: $image, rating: $rating}';
  }
}
