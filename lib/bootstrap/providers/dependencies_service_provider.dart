import 'package:flueco/flueco.dart';

import '../../data/repositories/developer_feed_repository_impl.dart';
import '../../data/repositories/static_portfolio_repository.dart';
import '../../data/sources/remote/github_remote_data_source.dart';
import '../../data/sources/remote/medium_remote_data_source.dart';
import '../../domain/contracts/developer_feed_repository.dart';
import '../../domain/contracts/portfolio_repository.dart';
import '../../domain/use_cases/get_developer_feed_use_case.dart';
import '../../domain/use_cases/get_portfolio_use_case.dart';
import '../../foundation/config/app_config.dart';

final class DependenciesServiceProvider extends ServiceProvider {
  final AppConfig appConfig;

  DependenciesServiceProvider({required this.appConfig});

  @override
  Future<void> register(ServiceInjector injector) async {
    injector
      ..lazySingleton<AppConfig>((_) => appConfig)
      ..factory<DioBaseOptionsProvider>(
        (_) => DefaultDioBaseOptionsProvider(''),
      )
      ..lazySingleton<PortfolioRepository>(
        (_) => StaticPortfolioRepository(),
      )
      ..factory<GitHubRemoteDataSource>(
        (ServiceResolver resolver) => GitHubRemoteDataSource(
          httpClient: resolver.resolve<HttpClient>(),
          config: resolver.resolve<AppConfig>(),
        ),
      )
      ..factory<MediumRemoteDataSource>(
        (ServiceResolver resolver) => MediumRemoteDataSource(
          httpClient: resolver.resolve<HttpClient>(),
          config: resolver.resolve<AppConfig>(),
        ),
      )
      ..lazySingleton<DeveloperFeedRepository>(
        (ServiceResolver resolver) => DeveloperFeedRepositoryImpl(
          github: resolver.resolve<GitHubRemoteDataSource>(),
          medium: resolver.resolve<MediumRemoteDataSource>(),
        ),
      )
      ..factory<GetPortfolioUseCase>(
        (ServiceResolver resolver) =>
            GetPortfolioUseCase(resolver.resolve<PortfolioRepository>()),
      )
      ..factory<GetDeveloperFeedUseCase>(
        (ServiceResolver resolver) => GetDeveloperFeedUseCase(
          resolver.resolve<DeveloperFeedRepository>(),
        ),
      );
  }

  @override
  Future<void> initialize(FluecoApp app) async {}

  @override
  Set<Type> registered() => <Type>{
        AppConfig,
        DioBaseOptionsProvider,
        PortfolioRepository,
        DeveloperFeedRepository,
        GetPortfolioUseCase,
        GetDeveloperFeedUseCase,
      };
}
