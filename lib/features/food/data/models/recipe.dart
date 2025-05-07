class Recipe {
  String recipeId;
  String name;
  Difficulty difficulty;
  String image;
  bool isFavorite;
  int favorites;
  int rating;
  int estimationTime;

  Recipe({
    required this.recipeId,
    required this.name,
    required this.difficulty,
    required this.image,
    required this.isFavorite,
    required this.favorites,
    required this.rating,
    required this.estimationTime,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        recipeId: json["recipe_id"],
        name: json["name"],
        difficulty: difficultyValues.map[json["difficulty"]]!,
        image: json["image"],
        isFavorite: json["isFavorite"],
        favorites: json["favorites"],
        rating: json["rating"],
        estimationTime: json["estimation_time"],
      );

  Map<String, dynamic> toJson() => {
        "recipe_id": recipeId,
        "name": name,
        "difficulty": difficultyValues.reverse[difficulty],
        "image": image,
        "isFavorite": isFavorite,
        "favorites": favorites,
        "rating": rating,
        "estimation_time": estimationTime,
      };
}

enum Difficulty { EASY, HARD, MEDIUM }

final difficultyValues = EnumValues({
  "Easy": Difficulty.EASY,
  "Hard": Difficulty.HARD,
  "Medium": Difficulty.MEDIUM
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
