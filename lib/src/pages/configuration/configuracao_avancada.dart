// File: ConfiguracaoAvancada.dart
import 'package:catalago_colecionadores/src/core/database/backup/backup_database.dart';
import 'package:catalago_colecionadores/src/core/database/isar_service.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/pages/configuration/widgets/circle_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

// Main entry widget for the ConfiguracaoAvancada screen
class ConfiguracaoAvancada extends StatefulWidget {
  const ConfiguracaoAvancada({super.key});

  @override
  State<ConfiguracaoAvancada> createState() => _ConfiguracaoAvancadaState();
}

class _ConfiguracaoAvancadaState extends State<ConfiguracaoAvancada> {
  // For demonstration: change this for navigation logic as needed
  int _selectedNavIndex = 2; // Default: Profile (matches original context)

  // Navigation using Navigator 1.0 - placeholder logic
  void _onNavTap(int index) {
    setState(() {
      _selectedNavIndex = index;
      // Example: Based on index, push new page
      // switch (index) {
      //   case 0: Navigator.pushNamed(context, '/catalog'); break;
      //   ...
      // }
    });
  }

  double _responsivePadding(BuildContext context, double screenWidth) {
    // Per CSS @media queries
    if (screenWidth <= 390) return screenWidth * 0.03;
    if (screenWidth <= 430) return screenWidth * 0.06;
    return 23.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;

            final mq = MediaQuery.of(context);
            final screenWidth = mq.size.width;

            final horizontalPadding = _responsivePadding(context, screenWidth);
            final sizeOf = MediaQuery.sizeOf(context);

            return Container(
              constraints: BoxConstraints(minHeight: sizeOf.height),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(R.ASSETS_IMAGES_CAPA_START_PNG),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // Main scrollable content, leaving space for the footer
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(
                          20,
                          18,
                          20,
                          16,
                        ), // as per CSS
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: CatalagoColecionadorTheme.blackClaroColor,
                              width: 1,
                            ),
                          ),
                        ),
                        child: _HeaderSection(),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            maxWidth: double.infinity,
                          ),
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Color(0xFF243647)),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: horizontalPadding,
                                right: horizontalPadding,
                                top: 0,
                                // bottom: 16, // DO NOT overlap footer
                              ),
                              child: _DataManagementSection(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Footer navigation (fixed)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 8),
        InkWell(
          child: CircleIcon(url: 'seta_esquerda.svg', size: 28),
          onTap: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
        ),
        SizedBox(width: 17),
        Text(
          'Configurações Avançadas',
          style: CatalagoColecionadorTheme.titleStyle.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: CatalagoColecionadorTheme.whiteColor,
            letterSpacing: 0,
            height: 1.25,
          ),
          semanticsLabel: "Settings",
        ),
      ],
    );
  }
}

// Data Management section
class _DataManagementSection extends StatelessWidget {
  const _DataManagementSection({super.key});

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
          _FeatureTile(
            iconUrl: 'export_icon.svg',
            title: "Export Data",
            description: "Exporta os dados para CSV / JSON",
            titleFontSize: 14,
            descFontSize: 20,
          ),
          _FeatureTile(
            iconUrl: 'backup_nuvem.svg',
            title: "Backup Completo (Zip)",
            description: "Backup dos files e dados para o zip",
            titleFontSize: 14,
            descFontSize: 20,
            onTap: () async {
              _handleBackup(context, FullZipBackupStrategy());
            },
          ),
          _FeatureTile(
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

// Advanced feature tile
class _FeatureTile extends StatelessWidget {
  final String iconUrl;
  final String title;
  final String description;
  final double titleFontSize;
  final double descFontSize;
  final bool isLast;
  final VoidCallback? onTap;

  const _FeatureTile({
    super.key,
    required this.iconUrl,
    required this.title,
    required this.description,
    required this.titleFontSize,
    required this.descFontSize,
    this.isLast = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      container: true,
      label: title,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: isLast ? 0 : 14),
        decoration: BoxDecoration(
          color: CatalagoColecionadorTheme.bgInputAccent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ).copyWith(left: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Feature icon
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: SvgPicture.asset(
                      'assets/images/$iconUrl', // Path to your SVG asset
                      height: 48,
                      width: 48,
                      colorFilter: ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                      semanticsLabel: "icon",
                    ),
                  ),
                ),
                // Description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w600,
                          color: CatalagoColecionadorTheme.whiteColor,
                          height: 1.14,
                          letterSpacing: -0.01,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        description,
                        style: CatalagoColecionadorTheme.titleSmallStyle.copyWith(
                          fontSize: descFontSize,
                          color: CatalagoColecionadorTheme.navBarBackkgroundColor,
                          fontWeight: FontWeight.w500,
                          height: 1.38,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
