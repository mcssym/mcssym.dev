import '../../domain/contracts/developer_feed_repository.dart';
import '../../domain/entities/article.dart';
import '../../domain/entities/repository.dart';
import '../sources/remote/github_remote_data_source.dart';
import '../sources/remote/medium_remote_data_source.dart';

final class DeveloperFeedRepositoryImpl implements DeveloperFeedRepository {
  final GitHubRemoteDataSource _github;
  final MediumRemoteDataSource _medium;

  const DeveloperFeedRepositoryImpl({
    required GitHubRemoteDataSource github,
    required MediumRemoteDataSource medium,
  })  : _github = github,
        _medium = medium;

  @override
  Future<List<Article>> getLatestArticles({int limit = 4}) =>
      _medium.getLatestArticles(limit: limit);

  @override
  Future<List<Repository>> getLatestRepositories({int limit = 6}) =>
      _github.getLatestRepositories(limit: limit);
}
