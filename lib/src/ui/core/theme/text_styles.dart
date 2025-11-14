import 'package:catalago_colecionadores/src/ui/core/theme/catalago_colecionador_theme.dart';
import 'package:flutter/cupertino.dart';

abstract final class AppTextStyles {
  static const titleLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static const subtitleSmall = TextStyle(
    fontSize: 14,
    color: CatalagoColecionadorTheme.whiteColor,
  );

  static const regularSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const boldSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static const boldMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const semiBoldMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const boldLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const lightGreyRegular = TextStyle(
    fontSize: 14,
    color: CatalagoColecionadorTheme.whiteColor,
  );

  static const lightGreySmall = TextStyle(
    fontSize: 12,
    color: CatalagoColecionadorTheme.orangeColor,
  );

  static const errorText = TextStyle(
    color: CatalagoColecionadorTheme.blueColor,
  );
}
