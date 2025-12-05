import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/core/ui/widgets/miniaturas_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/global/global_itens.dart';
import 'widgets/circle_icon.dart';
import 'widgets/config_content_section.dart';

// Color palette as per original CSS.

final int _selectedNavIndex = 3;

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  // You can add state variables here if you want interaction later.

  // Helper to adjust sizes responsively with breakpoints
  double _responsivePadding(BuildContext context, double screenWidth) {
    // Per CSS @media queries
    if (screenWidth <= 390) return screenWidth * 0.03;
    if (screenWidth <= 430) return screenWidth * 0.06;
    return 23.0;
  }

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery for full width/maxWidth as in the HTML/CSS
    final mq = MediaQuery.of(context);
    final screenWidth = mq.size.width;
    final bottomNavHeight = 56.0; // Based on estimated footer height

    final horizontalPadding = _responsivePadding(context, screenWidth);
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final maxWidth = constraints.maxWidth;

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
                  // Header Section
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
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                            bottom:
                                bottomNavHeight +
                                24, // Add extra for floating footer
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding,
                              vertical: 18,
                            ),
                            child: ConfigContentSection(),
                          ),
                        ),
                      ),
                      // Spacer to ensure footer (fixed) does not cover content
                      SizedBox(height: 6),
                      // Footer (fixed)
                      MiniaturasNavBar(
                        items: GlobalItens.navItems,
                        selectedIndex: _selectedNavIndex,
                        navHeight: maxWidth < 600 ? 67 : 80,
                        iconSize: maxWidth < 600 ? 22 : 27,
                        labelFontSize: maxWidth < 600 ? 10.6 : 12.2,
                        navItemWidth: maxWidth < 600 ? 76 : 80,
                      ),
                    ],
                  ),

                  // Main content (list & header)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// --- HEADER ---

class _HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 8),
        InkWell(
          child: CircleIcon(url: 'seta_esquerda.svg', size: 28),
          onTap: () => context.pop(),
        ),
        SizedBox(width: 17),
        Text(
          'Configurações',
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
