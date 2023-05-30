import 'package:app_agendamento/core/flavor/flavor_config.dart';
import 'package:app_agendamento/core/route/app_routes.dart';
import 'package:flutter/material.dart';

void bootstrap(FlavorConfig config) {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
