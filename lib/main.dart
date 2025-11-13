import 'dart:async';
import 'dart:developer';

import 'package:catalago_colecionadores/colecao_main_app.dart';
import 'package:flutter/material.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    //_cameras = await availableCameras();
    runApp(const ColecaoMainApp());
  }, (error, stack) {
    log('Erro não tratado', error: error, stackTrace: stack);
    throw error;
  });
}
