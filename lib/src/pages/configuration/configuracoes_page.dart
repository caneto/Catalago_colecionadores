import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/core/ui/widgets/miniaturas_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/global/global_itens.dart';

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
                            child: _ConfigContentSection(),
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
          child: _CircleIcon(url: 'seta_esquerda.svg', size: 28),
          onTap: () => Navigator.of(context).pop(),
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

// --- CONFIG CONTENT ---

class _ConfigContentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Structure as per HTML blocks
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ConfigSection(
          title: 'Notificações',
          children: [
            _ConfigDetailCard(
              iconUrl: 'notification_option.svg',
              title: 'Notificações de Lançamentos',
              subtitle: 'Gerenciar notificações para novos lançamentos',
              switchActivity: true
            ),
            SizedBox(height: 4),
            _ConfigDetailCard(
              iconUrl: 'notification_option.svg',
              title: 'Notificações de mudanças de preço',
              subtitle:
                  'Receba alertas sobre novos modelos e mudanças de preço',
              switchActivity: true,
            ),
          ],
        ),
        SizedBox(height: 14),
        // Conta
        _ConfigSection(
          title: 'Preferencias',
          children: [
            _ConfigDetailCard(
              iconUrl: 'visibilidade.svg',
              title: 'Visibilidade da coleção',
              subtitle: 'Torne sua coleção visível para outros usuários',
              switchActivity: true,
            ),
          ],
        ),
        SizedBox(height: 14),
        InkWell(
          onTap: () {},
          child: _ConfigSection(
            title: 'Conta',
            children: [
              _ConfigDetailCard(
                iconUrl: 'account.svg',
                title: 'Informações da conta',
                subtitle: 'Gerenciar informações da conta',
                withIcon: true,
              ),
            ],
          ),
        ),
        SizedBox(height: 14),
        // Preferências
        _ConfigSection(
          title: 'Preferências',
          children: [
            _ConfigDetailCard(
              iconUrl: 'idioma.svg',
              title: 'Idioma',
              subtitle: 'Escolha seu idioma preferido',
            ),
            SizedBox(height: 4),
            _ConfigDetailCard(
              iconUrl: 'thema.svg',
              title: 'Tema',
              subtitle: 'Tema claro ou escuro',
            ),
            SizedBox(height: 4),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/list_category');
              },
              child: _ConfigDetailCard(
                iconUrl: 'categoria.svg',
                title: 'Administrar Categorias',
                subtitle: 'Administração das Categorias',
                withIcon: true,
              ),
            ),
            SizedBox(height: 4),
            InkWell(
              onTap: () {},
              child: _ConfigDetailCard(
                iconUrl: 'marca.svg',
                title: 'Administrar Marca',
                subtitle: 'Adiministração das Marcas',
                withIcon: true,
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        // Legal (no subtitle)
        _ConfigSection(
          title: 'Legal',
          children: [
            InkWell(
              onTap: () {},
              child: _ConfigDetailCard(
                iconUrl: 'termos_legais.svg',
                title: 'Termos de uso',
                withIcon: true,
              ),
            ),
            SizedBox(height: 4),
            InkWell(
              onTap: () {},
              child: _ConfigDetailCard(
                iconUrl: 'politica_privacidade.svg',
                title: 'Política de privacidade',
                marginBottom: 0,
                withIcon: true,
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        // Legal (no subtitle)
        _ConfigSection(
          title: 'Ajuda e suporte',
          children: [
            InkWell(
              onTap: () {},
              child: _ConfigDetailCard(
                iconUrl: 'suporte.svg',
                title: 'Perguntas frequentes',
                withIcon: true,
              ),
            ),
            SizedBox(height: 4),
            InkWell(
              onTap: () {},
              child: _ConfigDetailCard(
                iconUrl: 'suporte.svg',
                title: 'Fale conosco',
                marginBottom: 0,
                withIcon: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ConfigSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _ConfigSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
            fontSize: 14.5,
            fontWeight: FontWeight.w700,
            color: CatalagoColecionadorTheme.whiteColor,
            letterSpacing: 0.02,
            height: 1.15,
          ),
        ),
        SizedBox(height: 7),
        ...children,
      ],
    );
  }
}

// ignore: must_be_immutable
class _ConfigDetailCard extends StatefulWidget {
  final String iconUrl;
  final String title;
  final String? subtitle;
  final double? marginBottom;
  final bool? withIcon;
  final bool? switchActivity;
  bool lightTheme;

  _ConfigDetailCard({
    required this.iconUrl,
    required this.title,
    this.subtitle,
    this.marginBottom = 9,
    this.withIcon = false,
    this.switchActivity = false,
    this.lightTheme = true,
  });

  @override
  State<_ConfigDetailCard> createState() => _ConfigDetailCardState();
}

class _ConfigDetailCardState extends State<_ConfigDetailCard> {
  WidgetStateProperty<Color?> trackColor = WidgetStateProperty<Color?>.fromMap(
    <WidgetStatesConstraint, Color>{WidgetState.selected: Colors.lightBlue},
  );
  final WidgetStateProperty<Color?> overlayColor =
      WidgetStateProperty<Color?>.fromMap(<WidgetState, Color>{
        WidgetState.selected: Colors.lightBlue.withValues(alpha: 0.54),
        WidgetState.disabled: Colors.grey.shade400,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: widget.marginBottom ?? 9),
      decoration: BoxDecoration(
        color: CatalagoColecionadorTheme.bgCard,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _CircleIcon(url: widget.iconUrl, size: 37),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: CatalagoColecionadorTheme.titleSmallStyle.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: CatalagoColecionadorTheme.whiteColor,
                    height: 20 / 15,
                  ),
                  semanticsLabel: widget.title,
                ),
                if (widget.subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 1.5),
                    child: Text(
                      widget.subtitle!,
                      style: CatalagoColecionadorTheme.titleSmallStyle.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: CatalagoColecionadorTheme.navBarBackkgroundColor,
                      ),
                      semanticsLabel: widget.subtitle,
                    ),
                  ),
              ],
            ),
          ),
          if (widget.withIcon ?? false)
            Align(
              alignment: AlignmentGeometry.centerRight,
              child: SvgPicture.asset(
                'assets/images/seta_direita.svg',
                height: 28,
                width: 28,
              ),
            ),
          if (widget.switchActivity ?? false)
            Switch(
              value: widget.lightTheme,
              overlayColor: overlayColor,
              trackColor: trackColor,
              thumbColor: const WidgetStatePropertyAll<Color>(Colors.black),
              onChanged: (bool value) {
                setState(() {
                  widget.lightTheme = value;
                });
              },
            ),
        ],
      ),
    );
  }
}

// --- CIRCLE ICON WIDGET ---
class _CircleIcon extends StatelessWidget {
  final String url;
  final double size;

  const _CircleIcon({required this.url, required this.size});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "icon",
      child: SvgPicture.asset(
        'assets/images/$url', // Path to your SVG asset
        height: size,
        width: size,
        semanticsLabel: "icon",
      ),
    );
  }
}
