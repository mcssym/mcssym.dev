import 'localized_text.dart';

final class Experience {
  final String company;
  final LocalizedText role;
  final String start;
  final String end;
  final LocalizedText? location;
  final LocalizedText? summary;

  const Experience({
    required this.company,
    required this.role,
    required this.start,
    required this.end,
    this.location,
    this.summary,
  });
}
