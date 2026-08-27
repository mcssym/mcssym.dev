import 'package:flueco_state_management/flueco_state_management.dart';

import '../../../../../domain/entities/portfolio.dart';
import '../../../../../domain/use_cases/get_developer_feed_use_case.dart';
import '../../../../../domain/use_cases/get_portfolio_use_case.dart';
import 'home.viewstate.dart';

final class HomeViewModel extends ViewModel<HomeViewState> {
  final GetPortfolioUseCase _getPortfolio;
  final GetDeveloperFeedUseCase _getFeed;

  HomeViewModel({
    required GetPortfolioUseCase getPortfolio,
    required GetDeveloperFeedUseCase getFeed,
  })  : _getPortfolio = getPortfolio,
        _getFeed = getFeed,
        super(const HomeViewState());

  Future<void> initialize() async {
    final Portfolio portfolio = await _getPortfolio.execute();
    setState(state.copyWith(portfolio: portfolio));

    try {
      final DeveloperFeed feed = await _getFeed.execute();
      setState(state.copyWith(
        repositories: feed.repositories,
        articles: feed.articles,
        loading: false,
      ));
    } catch (_) {
      setState(state.copyWith(loading: false, feedFailed: true));
    }
  }

  void toggleTheme() => setState(state.copyWith(darkMode: !state.darkMode));

  void toggleLanguage() => setState(
        state.copyWith(languageCode: state.languageCode == 'en' ? 'fr' : 'en'),
      );
}
