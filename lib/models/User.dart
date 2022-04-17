class User {
  User({required this.title, required this.genre});

  User.fromJson(Map<String, Object?> json)
    : this(
        title: json['title']! as String,
        genre: json['genre']! as String,
      );

  final String title;
  final String genre;

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'genre': genre,
    };
  }
}