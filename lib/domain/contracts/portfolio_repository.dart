import '../entities/portfolio.dart';

abstract interface class PortfolioRepository {
  Future<Portfolio> getPortfolio();
}
