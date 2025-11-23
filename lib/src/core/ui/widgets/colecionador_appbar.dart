import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:flutter/material.dart';

class ColecionadorAppbar extends AppBar {
  ColecionadorAppbar({
    super.key,
    double elevation = 1,
  }) : super(
          elevation: elevation,
          title: Image.asset(
            R.ASSETS_IMAGES_LOGO_PNG,
            width: 60,
          ),
          backgroundColor: CatalagoColecionadorTheme.barColor,
        );
}
