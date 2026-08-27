final class Repository {
  final String name;
  final String description;
  final String url;
  final String language;
  final int stars;
  final int forks;
  final DateTime? pushedAt;

  const Repository({
    required this.name,
    required this.description,
    required this.url,
    required this.language,
    required this.stars,
    required this.forks,
    required this.pushedAt,
  });
}
