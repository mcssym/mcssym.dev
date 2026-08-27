import '../entities/article.dart';
import '../entities/repository.dart';

abstract interface class DeveloperFeedRepository {
  Future<List<Repository>> getLatestRepositories({int limit = 6});
  Future<List<Article>> getLatestArticles({int limit = 4});
}
