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

class MockHomeData {
  static const MovieModel featuredMovie = MovieModel(
    id: '1',
    title: 'Spartacus',
    imageUrl: 'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=800&q=80',
    badgeText: '#2 in Nigeria Today',
  );

  static const List<MovieModel> previews = [
    MovieModel(
      id: 'p1',
      title: 'Vikings',
      imageUrl: 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=300&q=80',
    ),
    MovieModel(
      id: 'p2',
      title: 'Rogue',
      imageUrl: 'https://images.unsplash.com/photo-1574267432553-4b4628081c31?w=300&q=80',
    ),
    MovieModel(
      id: 'p3',
      title: "Queen's Gambit",
      imageUrl: 'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=300&q=80',
    ),
    MovieModel(
      id: 'p4',
      title: 'Extraction',
      imageUrl: 'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=300&q=80',
    ),
    MovieModel(
      id: 'p5',
      title: 'Stranger Things',
      imageUrl: 'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?w=300&q=80',
    ),
  ];

  static const List<MovieModel> continueWatching = [
    MovieModel(
      id: 'cw1',
      title: 'Night Agent',
      imageUrl: 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=400&q=80',
      progress: 0.7,
    ),
    MovieModel(
      id: 'cw2',
      title: 'Manifest',
      imageUrl: 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=400&q=80',
      progress: 0.45,
    ),
    MovieModel(
      id: 'cw3',
      title: 'Suits',
      imageUrl: 'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=400&q=80',
      progress: 0.85,
    ),
    MovieModel(
      id: 'cw4',
      title: 'The Witcher',
      imageUrl: 'https://images.unsplash.com/photo-1574267432553-4b4628081c31?w=400&q=80',
      progress: 0.3,
    ),
  ];
}
