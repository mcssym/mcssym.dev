import '../contracts/developer_feed_repository.dart';
import '../entities/article.dart';
import '../entities/repository.dart';

final class DeveloperFeed {
  final List<Repository> repositories;
  final List<Article> articles;

  const DeveloperFeed({required this.repositories, required this.articles});
}

final class GetDeveloperFeedUseCase {
  final DeveloperFeedRepository _repository;

  const GetDeveloperFeedUseCase(this._repository);

  Future<DeveloperFeed> execute() async {
    final List<Object> values = await Future.wait<Object>(<Future<Object>>[
      _repository.getLatestRepositories(),
      _repository.getLatestArticles(),
    ]);
    return DeveloperFeed(
      repositories: values[0] as List<Repository>,
      articles: values[1] as List<Article>,
    );
  }
}
