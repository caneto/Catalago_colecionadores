import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/pages/add_car/add_car_colection.dart';
import 'package:catalago_colecionadores/src/pages/auth/login/login_page.dart';
import 'package:catalago_colecionadores/src/pages/auth/registro/register_page.dart';
import 'package:catalago_colecionadores/src/pages/home/miniaturas_home.dart';
import 'package:catalago_colecionadores/src/pages/minhacolecao/minha_colecao.dart';
import 'package:catalago_colecionadores/src/pages/pos_start/pos_start_screen.dart';
import 'package:catalago_colecionadores/src/pages/splash/splash_screen.dart';
import 'package:catalago_colecionadores/src/pages/start/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'global.dart';

class ColecaoMainApp extends StatelessWidget {
  const ColecaoMainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessengerKey,
      title: 'Minha Coleção',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations
            .delegate, // Adicione este delegado para iOS
      ],
      supportedLocales: const [
        Locale('pt', 'BR'), // Defina o suporte para português do Brasil
      ],
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
        '/add_car': (_) => AddCarColection(),
        '/minha_colecao': (_) => MinhaColecao(),
      },
    );
  }
}
