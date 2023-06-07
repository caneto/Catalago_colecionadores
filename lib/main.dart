import 'package:app_agendamento/src/app.dart';
import 'package:app_agendamento/src/core/flavor/flavor_config.dart';

void main() {
  bootstrap(
    FlavorConfig(
      baseUrl: 'www.google.com.br',
      flavor: AppFlavor.prod,
    ),
  );
}
