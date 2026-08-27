import 'localized_text.dart';

final class FeaturedProject {
  final String name;
  final String role;
  final String url;
  final LocalizedText description;
  final List<String> principles;

  const FeaturedProject({
    required this.name,
    required this.role,
    required this.url,
    required this.description,
    required this.principles,
  });
}
