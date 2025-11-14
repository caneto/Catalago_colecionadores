import 'package:catalago_colecionadores/src/ui/core/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/ui/splash/splash_screen.dart';
import 'package:catalago_colecionadores/src/ui/start/start_screen.dart';
import 'package:flutter/material.dart';

final navKey = GlobalKey<NavigatorState>();

class ColecaoMainApp extends StatelessWidget {
  const ColecaoMainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Minha Coleção',
      theme: CatalagoColecionadorTheme.lightTheme,
      darkTheme: CatalagoColecionadorTheme.darkTheme,
      navigatorKey: navKey,
      routes: {
        '/': (_) => SplashPage(),
        '/login': (_) => const SizedBox.shrink(),
        '/home': (_) => const SizedBox.shrink(),
        '/start': (_) => StartScreen(),
      },
    );
  }
}
