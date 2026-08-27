import 'package:flueco/flueco.dart';

import '../../../domain/entities/article.dart';
import '../../../foundation/config/app_config.dart';

final class MediumRemoteDataSource {
  final HttpClient _httpClient;
  final AppConfig _config;

  const MediumRemoteDataSource({
    required HttpClient httpClient,
    required AppConfig config,
  })  : _httpClient = httpClient,
        _config = config;

  Future<List<Article>> getLatestArticles({int limit = 4}) async {
    final HttpResponse<Map<String, dynamic>> response =
        await _httpClient.get<Map<String, dynamic>>(
      _config.mediumFeedProxyUrl,
      queryParameters: <String, dynamic>{
        'rss_url': 'https://medium.com/feed/@${_config.mediumUsername}',
      },
    );

    final List<dynamic> items =
        (response.data?['items'] as List<dynamic>?) ?? <dynamic>[];
    return items
        .whereType<Map<String, dynamic>>()
        .map(_fromJson)
        .take(limit)
        .toList(growable: false);
  }

  Article _fromJson(Map<String, dynamic> json) {
    final String rawDescription = json['description']?.toString() ?? '';
    return Article(
      title: json['title']?.toString() ?? '',
      description: _plainText(rawDescription),
      url: json['link']?.toString() ?? '',
      publishedAt: DateTime.tryParse(json['pubDate']?.toString() ?? ''),
      categories: (json['categories'] as List<dynamic>? ?? <dynamic>[])
          .map((dynamic value) => value.toString())
          .toList(growable: false),
    );
  }

  String _plainText(String value) {
    final String withoutTags = value.replaceAll(RegExp(r'<[^>]*>'), ' ');
    return withoutTags
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }
}
