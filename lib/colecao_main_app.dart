import 'package:camera_platform_interface/src/types/camera_description.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/pages/add_car/add_car_colection.dart';
import 'package:catalago_colecionadores/src/pages/add_car/scan/add_scan_page.dart';
import 'package:catalago_colecionadores/src/pages/auth/login/login_page.dart';
import 'package:catalago_colecionadores/src/pages/auth/registro/register_page.dart';
import 'package:catalago_colecionadores/src/pages/category/add_category_page.dart';
import 'package:catalago_colecionadores/src/pages/category/list_category_page.dart';
import 'package:catalago_colecionadores/src/pages/configuration/configuracoes_page.dart';
import 'package:catalago_colecionadores/src/pages/home/miniaturas_home.dart';
import 'package:catalago_colecionadores/src/pages/minhacolecao/minha_colecao.dart';
import 'package:catalago_colecionadores/src/pages/minhacolecao/minha_colecao_2.dart';
import 'package:catalago_colecionadores/src/pages/pos_start/pos_start_screen.dart';
import 'package:catalago_colecionadores/src/pages/splash/splash_screen.dart';
import 'package:catalago_colecionadores/src/pages/start/start_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';

import 'global.dart';

class ColecaoMainApp extends StatefulWidget {
  final List<CameraDescription> cameras;

  const ColecaoMainApp({super.key, required this.cameras});

  @override
  State<ColecaoMainApp> createState() => _ColecaoMainAppState();
}

class _ColecaoMainAppState extends State<ColecaoMainApp> {
  @override
  void initState() {
    super.initState();
    requestStoragePermission();
  }

  void requestStoragePermission() async {
    // Check if the platform is not web, as web has no permissions
    if (!kIsWeb) {
      // Request storage permission
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }

      // Request camera permission
      var cameraStatus = await Permission.camera.status;
      if (!cameraStatus.isGranted) {
        await Permission.camera.request();
      }
    }
  }

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
        '/add_car/scan': (_) => AddScanPage(cameras: widget.cameras),
        '/minha_colecao': (_) => MinhaColecao(),
        '/minha_colecao2': (_) => MinhaColecao2(),
        '/category': (_) => AddCategoryPage(),
        '/configuracoes': (_) => ConfiguracoesPage(),
        '/add_category_page': (_) => AddCategoryPage(),
        '/list_category': (_) => ListCategoryPage(),
      },
    );
  }
}
