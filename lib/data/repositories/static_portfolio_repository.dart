import '../../domain/contracts/portfolio_repository.dart';
import '../../domain/entities/portfolio.dart';
import '../../foundation/content/portfolio_content.dart';

final class StaticPortfolioRepository implements PortfolioRepository {
  @override
  Future<Portfolio> getPortfolio() async => portfolioContent;
}
