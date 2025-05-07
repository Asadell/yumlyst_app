class RecipeDetail {
  String recipeId;
  bool isFavorite;
  String name;
  String video;
  List<String> ingredients;
  List<String> tools;
  List<String> steps;
  int averageRating;
  int averageCount;
  String description;
  String estimateTime;
  int commentsCount;
  List<NutritionInformation> nutritionInformation;
  List<Review> reviews;

  RecipeDetail({
    required this.recipeId,
    required this.isFavorite,
    required this.name,
    required this.video,
    required this.ingredients,
    required this.tools,
    required this.steps,
    required this.averageRating,
    required this.averageCount,
    required this.description,
    required this.estimateTime,
    required this.commentsCount,
    required this.nutritionInformation,
    required this.reviews,
  });

  factory RecipeDetail.fromJson(Map<String, dynamic> json) => RecipeDetail(
        recipeId: json["recipe_id"],
        isFavorite: json["is_favorite"],
        name: json["name"],
        video: json["video"],
        ingredients: List<String>.from(json["ingredients"].map((x) => x)),
        tools: List<String>.from(json["tools"].map((x) => x)),
        steps: List<String>.from(json["steps"].map((x) => x)),
        averageRating: json["average_rating"],
        averageCount: json["average_count"],
        description: json["description"],
        estimateTime: json["estimate_time"],
        commentsCount: json["comments_count"],
        nutritionInformation: List<NutritionInformation>.from(
            json["nutrition_information"]
                .map((x) => NutritionInformation.fromJson(x))),
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "recipe_id": recipeId,
        "is_favorite": isFavorite,
        "name": name,
        "video": video,
        "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
        "tools": List<dynamic>.from(tools.map((x) => x)),
        "steps": List<dynamic>.from(steps.map((x) => x)),
        "average_rating": averageRating,
        "average_count": averageCount,
        "description": description,
        "estimate_time": estimateTime,
        "comments_count": commentsCount,
        "nutrition_information":
            List<dynamic>.from(nutritionInformation.map((x) => x.toJson())),
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
      };
}

class NutritionInformation {
  String nutritionId;
  String name;
  String amount;

  NutritionInformation({
    required this.nutritionId,
    required this.name,
    required this.amount,
  });

  factory NutritionInformation.fromJson(Map<String, dynamic> json) =>
      NutritionInformation(
        nutritionId: json["nutritionId"],
        name: json["name"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "nutritionId": nutritionId,
        "name": name,
        "amount": amount,
      };
}

class Review {
  String reviewId;
  String username;
  String avatar;
  int rating;
  String comment;
  String timeStamp;
  List<String> images;

  Review({
    required this.reviewId,
    required this.username,
    required this.avatar,
    required this.rating,
    required this.comment,
    required this.timeStamp,
    required this.images,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        reviewId: json["reviewId"],
        username: json["username"],
        avatar: json["avatar"],
        rating: json["rating"],
        comment: json["comment"],
        timeStamp: json["timeStamp"],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "reviewId": reviewId,
        "username": username,
        "avatar": avatar,
        "rating": rating,
        "comment": comment,
        "timeStamp": timeStamp,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}
