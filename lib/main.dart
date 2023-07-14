import 'package:app_agendamento/app.dart';
import 'package:app_agendamento/core/flavor/flavor_config.dart';

void main() {
  bootstrap(
    FlavorConfig(
      flavor: AppFlavor.prod,
      baseUrl: 'www.google.com.br',
      appId: '',
      restKey: '',
    ),
  );
}
