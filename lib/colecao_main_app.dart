import 'package:catalago_colecionadores/src/ui/core/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/ui/home/miniaturas_home.dart';
import 'package:catalago_colecionadores/src/ui/login/login_page.dart';
import 'package:catalago_colecionadores/src/ui/pos_start/pos_start_screen.dart';
import 'package:catalago_colecionadores/src/ui/registro/register_page.dart';
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
        '/login': (_) => LoginPage(),
        '/registro': (_) => RegisterPage(),
        '/home': (_) => MiniaturasHome(),
        '/start': (_) => StartScreen(),
        '/pos_start': (_) => PosStartScreen(),
      },
    );
  }
}
