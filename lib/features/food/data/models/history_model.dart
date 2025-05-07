class HistoryItem {
  final String id;
  final String foodName;
  final String date;
  final String time;
  final String duration;
  final int rating;
  final String imageUrl;
  final List<Review>? reviews;

  HistoryItem({
    required this.id,
    required this.foodName,
    required this.date,
    required this.time,
    required this.duration,
    required this.rating,
    required this.imageUrl,
    this.reviews,
  });
}

class Review {
  final String id;
  final String username;
  final String avatarUrl;
  final String date;
  final String time;
  final int rating;
  final String comment;
  final List<String> images;

  Review({
    required this.id,
    required this.username,
    required this.avatarUrl,
    required this.date,
    required this.time,
    required this.rating,
    required this.comment,
    required this.images,
  });
}
