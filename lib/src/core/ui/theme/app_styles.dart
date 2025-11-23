import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

class AppStyles {
  static AppStyles? _instance;
  // Avoid self isntance
  AppStyles._();
  static AppStyles get i {
    _instance ??= AppStyles._();
    return _instance!;
  }

  ButtonStyle get primaryButton => ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(7),
    ),
    backgroundColor: CatalagoColecionadorTheme.blueColor,
    textStyle: CatalagoColecionadorTheme.textTextButtonLabel
  );
}

extension AppStylesExtensions on BuildContext {
  AppStyles get appStyles => AppStyles.i;
}
