class MovieModel {
  final String id;
  final String title;
  final String imageUrl;
  final String? badgeText;
  final double? progress;

  const MovieModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.badgeText,
    this.progress,
  });
}
