final class LocalizedText {
  final String en;
  final String fr;

  const LocalizedText({required this.en, required this.fr});

  String resolve(String languageCode) => languageCode == 'fr' ? fr : en;
}
