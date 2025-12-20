import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'featuretile.dart';

class ExportSection extends StatelessWidget {
  const ExportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: "Export Section",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            "Exporta Conteudo",
            style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: CatalagoColecionadorTheme.whiteColor,
              letterSpacing: -0.01,
            ),
          ),
          const SizedBox(height: 20),
          FeatureTile(
            iconUrl: 'pdf_export.svg',
            title: "Gera PDF",
            description: "Gera PDF",
            titleFontSize: 14,
            descFontSize: 20,
            onTap: () async {
              context.push('/pdf_exports');
            },
          ),
          FeatureTile(
            iconUrl: 'csv_export.svg',
            title: "Exporta conteudo em CSV",
            description: "Exporta conteudo em CSV",
            titleFontSize: 14,
            descFontSize: 20,
            onTap: () async {
              
            },
          ),
          
        ],
      ),
    );
  }
}
