final class Article {
  final String title;
  final String description;
  final String url;
  final DateTime? publishedAt;
  final List<String> categories;

  const Article({
    required this.title,
    required this.description,
    required this.url,
    required this.publishedAt,
    required this.categories,
  });
}
