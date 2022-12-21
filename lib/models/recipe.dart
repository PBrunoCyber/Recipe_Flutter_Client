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
      image: json['images'][0]['hostedLargeUrl'] as String,
      rating: json['rating'] as double,
    );
  }

  static List<Recipe> recipeFromSnapShot(List snapshot) {
    return snapshot.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Recipe{name: $name, totalTime: $totalTime, image: $image, rating: $rating}';
  }
}
