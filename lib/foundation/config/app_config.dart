final class AppConfig {
  final String githubUsername;
  final String mediumUsername;
  final String mediumFeedProxyUrl;

  const AppConfig({
    required this.githubUsername,
    required this.mediumUsername,
    required this.mediumFeedProxyUrl,
  });

  const AppConfig.production()
      : githubUsername = 'mcssym',
        mediumUsername = 'mcssym',
        mediumFeedProxyUrl = 'https://api.rss2json.com/v1/api.json';
}
