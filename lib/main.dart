import 'dart:async';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:catalago_colecionadores/colecao_main_app.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> _cameras;

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    _cameras = await availableCameras();
    
    runApp(ColecaoMainApp(cameras: _cameras));
  }, (error, stack) {
    log('Erro não tratado', error: error, stackTrace: stack);
    throw error;
  });
}