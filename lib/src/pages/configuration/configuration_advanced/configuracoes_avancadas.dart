// File: ConfiguracaoAvancada.dart
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/pages/configuration/configuration_advanced/widgets/export_section.dart';
import 'package:flutter/material.dart';

import 'widgets/data_mamagement_section.dart';
import 'widgets/header_section.dart';

// Main entry widget for the ConfiguracaoAvancada screen
class ConfiguracoesAvancadas extends StatefulWidget {
  const ConfiguracoesAvancadas({super.key});

  @override
  State<ConfiguracoesAvancadas> createState() => _ConfiguracoesAvancadasState();
}

class _ConfiguracoesAvancadasState extends State<ConfiguracoesAvancadas> {
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
                        child: HeaderSection(),
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
                              child: Column(
                                children: [
                                  DataManagementSection(),
                                  const SizedBox(height: 12),
                                  ExportSection(),
                                ],
                              ),
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


