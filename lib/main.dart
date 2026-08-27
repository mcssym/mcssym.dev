import 'bootstrap/kernel.dart';
import 'foundation/config/app_config.dart';

Future<void> main() async {
  final Kernel kernel = Kernel(
    appConfig: const AppConfig.production(),
  );
  await kernel.bootstrap();
  kernel.run();
}
