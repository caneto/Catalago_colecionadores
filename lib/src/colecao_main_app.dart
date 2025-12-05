import 'package:camera_platform_interface/src/types/camera_description.dart';
import 'package:catalago_colecionadores/src/core/global/global.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';

import 'routes.dart';

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
    return MaterialApp.router(
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
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: CatalagoColecionadorTheme.lightTheme,
      darkTheme: CatalagoColecionadorTheme.darkTheme,
      routerConfig: router,
    );
  }
}
