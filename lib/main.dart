import 'dart:async';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:catalago_colecionadores/src/colecao_main_app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> _cameras;

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      _cameras = await availableCameras();

      runApp(
        DevicePreview(
          builder: (_) => ColecaoMainApp(cameras: _cameras),
          enabled: false,  // Para ativsar o preview, troque para true.
        ),
      );
    },
    (error, stack) {
      log('Erro não tratado', error: error, stackTrace: stack);
      throw error;
    },
  );
}
