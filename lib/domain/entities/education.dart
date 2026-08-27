import 'localized_text.dart';

final class Education {
  final String institution;
  final LocalizedText program;
  final String period;

  const Education({
    required this.institution,
    required this.program,
    required this.period,
  });
}
