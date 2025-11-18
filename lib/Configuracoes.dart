// File: Configuracoes.dart
import 'package:flutter/material.dart';

// Color palette as per original CSS.
const _backgroundColor = Color(0xFF211212);
const _primaryColor = Colors.white;
const _subtitleColor = Color(0xFFC99194);
const _cardBgColor = Color(0xFF472426);
const _sectionTitleColor = Colors.white;
const _borderColor = Color(0xFF472426);
const _footerBgColor = Color(0xFF331A1C);

class Configuracoes extends StatefulWidget {
  const Configuracoes({Key? key}) : super(key: key);

  @override
  State<Configuracoes> createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  // You can add state variables here if you want interaction later.

  // Helper to adjust sizes responsively with breakpoints
  double _responsivePadding(BuildContext context, double screenWidth) {
    // Per CSS @media queries
    if (screenWidth <= 390) return screenWidth * 0.03;
    if (screenWidth <= 430) return screenWidth * 0.06;
    return 23.0;
  }

  // Navigation stubs for the footer nav (implement with Navigator 1.0)
  void _onFooterTap(int index) {
    // Example navigation, implement as needed
    // To focus on the widget composition, navigation logic is stubbed
    // For a real app, use: Navigator.of(context).pushNamed('/some_route');
    // For now, only scroll up for "Inicio"
    if (index == 0) {
      // Do something or scroll to top
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery for full width/maxWidth as in the HTML/CSS
    final mq = MediaQuery.of(context);
    final screenWidth = mq.size.width;
    final boxMaxWidth = 430.0;
    final bottomNavHeight = 56.0; // Based on estimated footer height

    final horizontalPadding = _responsivePadding(context, screenWidth);

    return Scaffold(
      backgroundColor: _backgroundColor,
      // We use Stack to have footer overlay the content, as in HTML
      body: SafeArea(
        // For accessibility and padding on safe areas
        child: Stack(
          children: [
            // Main content (list & header)
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: boxMaxWidth,
                  ),
                  child: Column(
                    children: [
                      // Header Section
                      _HeaderSection(),
                      // Flexible content
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                            bottom: bottomNavHeight + 24, // Add extra for floating footer
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
                      SizedBox(height: bottomNavHeight + 8),
                    ],
                  ),
                ),
              ),
            ),
            // Footer (fixed)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: boxMaxWidth),
                  child: _FooterNav(
                    onTap: _onFooterTap,
                    activeIndex: 3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- HEADER ---

class _HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor,
        border: Border(
          bottom: BorderSide(color: _borderColor, width: 1),
        ),
      ),
      padding: const EdgeInsets.only(top: 22, bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 22),
          const _CircleIcon(
            url: 'https://app.codigma.io/api/uploads/assets/04416dba-06a4-423c-b4a0-7ccef2fded70.svg',
            size: 28,
          ),
          const SizedBox(width: 17),
          Text(
            'Configurações',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: _primaryColor,
              letterSpacing: 0,
              fontFamily: 'Plus Jakarta Sans',
              height: 1.25,
            ),
            semanticsLabel: "Settings",
          ),
        ],
      ),
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
        // Conta
        _ConfigSection(
          title: 'Conta',
          children: [
            _ConfigDetailCard(
              iconUrl: 'https://app.codigma.io/api/uploads/assets/be412102-d032-4b72-9df8-3880d4c53c4e.svg',
              title: 'Informações da conta',
              subtitle: 'Gerenciar informações da conta',
            ),
          ],
        ),
        SizedBox(height: 17),
        // Preferências
        _ConfigSection(
          title: 'Preferências',
          children: [
            _ConfigDetailCard(
              iconUrl: 'https://app.codigma.io/api/uploads/assets/67d18090-12ae-4bf5-ae7e-35fcbf9a3270.svg',
              title: 'Notificações',
              subtitle: 'Gerenciar suas preferências de notificação',
            ),
            SizedBox(height: 9),
            _ConfigDetailCard(
              iconUrl: 'https://app.codigma.io/api/uploads/assets/d5425afd-e3d1-410c-a302-a80acd0803da.svg',
              title: 'Idioma',
              subtitle: 'Escolha seu idioma preferido',
            ),
          ],
        ),
        SizedBox(height: 17),
        // Legal (no subtitle)
        _ConfigSection(
          title: 'Legal',
          children: [
            _ConfigDetailCard(
              iconUrl: 'https://app.codigma.io/api/uploads/assets/a3d2b0fb-ebc1-4058-bc81-8c73d86cc29a.svg',
              title: 'Termos de uso',
            ),
            SizedBox(height: 7),
            _ConfigDetailCard(
              iconUrl: 'https://app.codigma.io/api/uploads/assets/59384cac-ae2d-43da-b8d6-ecc82915d144.svg',
              title: 'Política de privacidade',
              marginBottom: 0,
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
          style: TextStyle(
            fontSize: 14.5,
            fontWeight: FontWeight.w700,
            color: _sectionTitleColor,
            letterSpacing: 0.02,
            fontFamily: 'Plus Jakarta Sans',
            height: 1.15,
          ),
        ),
        SizedBox(height: 7),
        ...children,
      ],
    );
  }
}

class _ConfigDetailCard extends StatelessWidget {
  final String iconUrl;
  final String title;
  final String? subtitle;
  final double? marginBottom;

  const _ConfigDetailCard({
    required this.iconUrl,
    required this.title,
    this.subtitle,
    this.marginBottom = 9,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: marginBottom ?? 9),
      decoration: BoxDecoration(
        color: _cardBgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _CircleIcon(url: iconUrl, size: 37),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: _primaryColor,
                    fontFamily: 'Plus Jakarta Sans',
                    height: 20 / 15,
                  ),
                  semanticsLabel: title,
                ),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 1.5),
                    child: Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: _subtitleColor,
                        fontFamily: 'Plus Jakarta Sans',
                      ),
                      semanticsLabel: subtitle,
                    ),
                  ),
              ],
            ),
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
      child: ClipOval(
        child: Image.network(
          url,
          width: size,
          height: size,
          fit: BoxFit.contain,
          errorBuilder: (ctx, err, stack) => Container(
            width: size,
            height: size,
            color: _borderColor,
            child: Icon(Icons.image_not_supported, color: Colors.white, size: size * 0.5),
          ),
        ),
      ),
    );
  }
}

// --- FOOTER NAVIGATION ---

class _FooterNav extends StatelessWidget {
  final void Function(int) onTap;
  final int activeIndex;
  const _FooterNav({
    required this.onTap,
    this.activeIndex = 0,
  });

  static final List<_FooterNavItemData> _items = [
    _FooterNavItemData(
      label: 'Início',
      iconUrl: 'https://app.codigma.io/api/uploads/assets/569213dd-9b97-4551-b185-9f75e4dbeb39.svg',
    ),
    _FooterNavItemData(
      label: 'Minha Coleção',
      iconUrl: 'https://app.codigma.io/api/uploads/assets/c7dbb258-52e0-48c8-8b86-dd776b0b6ec0.svg',
    ),
    _FooterNavItemData(
      label: 'Adicionar',
      iconUrl: 'https://app.codigma.io/api/uploads/assets/6ea163a0-a913-4e22-adcb-f0deefa1236e.svg',
    ),
    _FooterNavItemData(
      label: 'Configurações',
      iconUrl: 'https://app.codigma.io/api/uploads/assets/23594f86-6aaa-4906-98c7-fb3694b44cd4.svg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _footerBgColor,
      elevation: 8,
      child: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: _borderColor, width: 1.1)),
          color: _footerBgColor,
        ),
        padding: const EdgeInsets.only(top: 11, bottom: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_items.length, (index) {
            final isActive = index == activeIndex;
            return _FooterNavItem(
              data: _items[index],
              active: isActive,
              onTap: () => onTap(index),
            );
          }),
        ),
      ),
    );
  }
}

class _FooterNavItem extends StatelessWidget {
  final _FooterNavItemData data;
  final bool active;
  final VoidCallback onTap;
  const _FooterNavItem({
    required this.data,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? _primaryColor : _subtitleColor;

    return Semantics(
      button: true,
      label: data.label,
      selected: active,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                data.iconUrl,
                width: 29,
                height: 29,
                color: color,
                fit: BoxFit.contain,
                errorBuilder: (ctx, err, stack) => Icon(
                  Icons.image_not_supported,
                  color: color,
                  size: 21,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                data.label,
                style: TextStyle(
                  color: color,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Plus Jakarta Sans',
                  letterSpacing: 0.01,
                ),
                semanticsLabel: data.label,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterNavItemData {
  final String label;
  final String iconUrl;
  const _FooterNavItemData({
    required this.label,
    required this.iconUrl,
  });
}