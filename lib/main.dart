import 'dart:async';
import 'dart:developer';

import 'package:catalago_colecionadores/src/colecao_main_app.dart';
import 'package:catalago_colecionadores/src/core/env/env.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Parse().initialize(
        Env.appId,
        Env.baseUrl,
        clientKey: Env.clientKey,
        debug: true,
      );

      runApp(
        DevicePreview(
          builder: (_) => ColecaoMainApp(),
          enabled: false, // Para ativsar o preview, troque para true.
        ),
      );
    },
    (error, stack) {
      log('Erro não tratado', error: error, stackTrace: stack);
      throw error;
    },
  );
}
