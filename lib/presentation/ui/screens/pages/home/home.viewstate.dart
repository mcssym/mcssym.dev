import 'package:flueco_state_management/flueco_state_management.dart';

import '../../../../../domain/entities/article.dart';
import '../../../../../domain/entities/portfolio.dart';
import '../../../../../domain/entities/repository.dart';

final class HomeViewState extends ViewState {
  final Portfolio? portfolio;
  final List<Repository> repositories;
  final List<Article> articles;
  final bool loading;
  final bool feedFailed;
  final bool darkMode;
  final String languageCode;

  const HomeViewState({
    this.portfolio,
    this.repositories = const <Repository>[],
    this.articles = const <Article>[],
    this.loading = true,
    this.feedFailed = false,
    this.darkMode = false,
    this.languageCode = 'en',
  });

  HomeViewState copyWith({
    Portfolio? portfolio,
    List<Repository>? repositories,
    List<Article>? articles,
    bool? loading,
    bool? feedFailed,
    bool? darkMode,
    String? languageCode,
  }) {
    return HomeViewState(
      portfolio: portfolio ?? this.portfolio,
      repositories: repositories ?? this.repositories,
      articles: articles ?? this.articles,
      loading: loading ?? this.loading,
      feedFailed: feedFailed ?? this.feedFailed,
      darkMode: darkMode ?? this.darkMode,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        portfolio,
        repositories,
        articles,
        loading,
        feedFailed,
        darkMode,
        languageCode,
      ];
}
