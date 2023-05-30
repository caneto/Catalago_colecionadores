import 'package:app_agendamento/app.dart';
import 'package:app_agendamento/core/flavor/flavor_config.dart';

void main() {
  bootstrap(
    FlavorConfig(
      baseUrl: 'www.google.com.br',
      flavor: AppFlavor.prod,
    ),
  );
}
