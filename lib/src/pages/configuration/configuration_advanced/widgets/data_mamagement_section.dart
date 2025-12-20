import 'package:catalago_colecionadores/src/core/database/backup/backup_database.dart';
import 'package:catalago_colecionadores/src/core/database/isar_service.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

import 'featuretile.dart';

class DataManagementSection extends StatelessWidget {
  const DataManagementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: "Data Management Section",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            "Gerenciamento de Backup",
            style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: CatalagoColecionadorTheme.whiteColor,
              letterSpacing: -0.01,
            ),
          ),
          const SizedBox(height: 20),
          FeatureTile(
            iconUrl: 'export_icon.svg',
            title: "Export Data",
            description: "Exporta os dados para CSV / JSON",
            titleFontSize: 14,
            descFontSize: 20,
          ),
          FeatureTile(
            iconUrl: 'backup_nuvem.svg',
            title: "Backup Completo (Zip)",
            description: "Backup dos files e dados para o zip",
            titleFontSize: 14,
            descFontSize: 20,
            onTap: () async {
              _handleBackup(context, FullZipBackupStrategy());
            },
          ),
          FeatureTile(
            iconUrl: 'export_local.svg',
            title: "Backup JSON (Zip)",
            description: "Exporta os dados por tabela para JSON em zip",
            titleFontSize: 14,
            descFontSize: 20,
            isLast: true,
            onTap: () async {
              _handleBackup(context, JsonZipBackupStrategy());
            },
          ),
        ],
      ),
    );
  }

  Future<void> _handleBackup(
    BuildContext context,
    BackupStrategy strategy,
  ) async {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Iniciando backup...')));
    try {
      final isarService = IsarService();
      final isar = await isarService.db;
      final service = BackupService();
      final result = await service.performBackup(isar, strategy);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(result)));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro: $e')));
      }
    }
  }
}
