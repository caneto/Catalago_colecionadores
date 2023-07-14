import 'package:app_agendamento/app.dart';
import 'package:app_agendamento/core/flavor/flavor_config.dart';

void main() {
  bootstrap(
    FlavorConfig(
      flavor: AppFlavor.dev,
      baseUrl: 'https://parseapi.back4app.com/functions',
      appId: 'aTF0s4pymeWyw1m6R7YWSl6npiQkN8XmEtBvjVsa',
      restKey: 'T8mBHK100ovBD2Pu8RabV6ox1SPzV5hY2LzPX7dH',
    ),
  );
}
