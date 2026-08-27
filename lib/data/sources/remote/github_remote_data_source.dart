import 'package:flueco/flueco.dart';

import '../../../domain/entities/repository.dart';
import '../../../foundation/config/app_config.dart';

final class GitHubRemoteDataSource {
  final HttpClient _httpClient;
  final AppConfig _config;

  const GitHubRemoteDataSource({
    required HttpClient httpClient,
    required AppConfig config,
  })  : _httpClient = httpClient,
        _config = config;

  Future<List<Repository>> getLatestRepositories({int limit = 6}) async {
    final HttpResponse<List<dynamic>> response =
        await _httpClient.get<List<dynamic>>(
      'https://api.github.com/users/${_config.githubUsername}/repos',
      queryParameters: <String, dynamic>{
        'sort': 'pushed',
        'direction': 'desc',
        'per_page': 30,
        'type': 'owner',
      },
      headers: <String, dynamic>{
        'Accept': 'application/vnd.github+json',
        'X-GitHub-Api-Version': '2022-11-28',
      },
    );

    final List<dynamic> data = response.data ?? <dynamic>[];
    return data
        .whereType<Map<String, dynamic>>()
        .where((Map<String, dynamic> json) => json['fork'] != true)
        .map(_fromJson)
        .take(limit)
        .toList(growable: false);
  }

  Repository _fromJson(Map<String, dynamic> json) {
    return Repository(
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      url: json['html_url']?.toString() ?? '',
      language: json['language']?.toString() ?? 'Mixed',
      stars: (json['stargazers_count'] as num?)?.toInt() ?? 0,
      forks: (json['forks_count'] as num?)?.toInt() ?? 0,
      pushedAt: DateTime.tryParse(json['pushed_at']?.toString() ?? ''),
    );
  }
}
