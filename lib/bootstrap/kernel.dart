import 'package:flueco/flueco.dart';
import 'package:flutter/widgets.dart';

import '../foundation/config/app_config.dart';
import '../presentation/ui/app.dart';
import 'providers/dependencies_service_provider.dart';

final GetItServiceContainer _container = GetItServiceContainer();

final class Kernel {
  final AppConfig appConfig;
  final FluecoKernel _fluecoKernel;

  Kernel({required this.appConfig})
      : _fluecoKernel = FluecoKernel(
          container: _container,
          serviceProviders: <ServiceProvider>{
            DependenciesServiceProvider(appConfig: appConfig),
            DioServiceProvider(),
          },
        );

  Future<void> bootstrap() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _fluecoKernel.bootstrap();
  }

  void run() => runApp(
        Flueco(
          kernel: _fluecoKernel,
          child: const App(),
        ),
      );
}
