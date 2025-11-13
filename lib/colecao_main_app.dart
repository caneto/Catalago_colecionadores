import 'package:catalago_colecionadores/src/ui/core/theme/theme.dart';
import 'package:catalago_colecionadores/src/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';

final navKey = GlobalKey<NavigatorState>();

class ColecaoMainApp extends StatelessWidget {
  const ColecaoMainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Minha Coleção',
      theme: AppTheme.theme,
      navigatorKey: navKey,
      routes: {
        '/': (_) => SplashPage(),
      },
    );
  }
}
