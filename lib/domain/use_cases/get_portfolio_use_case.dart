import '../contracts/portfolio_repository.dart';
import '../entities/portfolio.dart';

final class GetPortfolioUseCase {
  final PortfolioRepository _repository;

  const GetPortfolioUseCase(this._repository);

  Future<Portfolio> execute() => _repository.getPortfolio();
}
