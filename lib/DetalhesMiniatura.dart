// File: DetalhesMiniatura.dart
import 'package:flutter/material.dart';

// Main entry widget for the DetalhesMiniatura screen.
class DetalhesMiniatura extends StatefulWidget {
  const DetalhesMiniatura({Key? key}) : super(key: key);

  @override
  State<DetalhesMiniatura> createState() => _DetalhesMiniaturaState();
}

class _DetalhesMiniaturaState extends State<DetalhesMiniatura> {
  // Selected gallery image index (always initially 0).
  int selectedGalleryIndex = 0;

  // Demo data for images and details.
  final List<_MiniaturaGalleryImage> _galleryImages = const [
    _MiniaturaGalleryImage(
      url: "https://app.codigma.io/api/uploads/assets/ef7dfde7-f712-4357-b7b7-a8f9c4de2dc4.png",
      alt: "Thumbnail 1",
    ),
    _MiniaturaGalleryImage(
      url: "https://app.codigma.io/api/uploads/assets/6dedb7f2-5084-4da2-8849-437b7dc896a6.png",
      alt: "Thumbnail 2",
    ),
    _MiniaturaGalleryImage(
      url: "https://app.codigma.io/api/uploads/assets/6ccadf77-46a4-48af-8594-0a3b11f39bbb.png",
      alt: "Thumbnail 3",
    ),
  ];

  final List<_ModelDetail> _details = const [
    _ModelDetail(label: "Marca", value: "Hot Wheels"),
    _ModelDetail(label: "Modelo", value: "Ford Mustang"),
    _ModelDetail(label: "Ano", value: "1967"),
    _ModelDetail(label: "Escala", value: "1:64"),
    _ModelDetail(label: "Condição", value: "Excelente"),
    _ModelDetail(label: "Observações", value: "Edição limitada, pintura original"),
  ];

  // Simulate action button state.
  bool _isRemoved = false;
  bool _isButtonPressed = false;

  // Footer navigation items data
  static const _footerNavItems = [
    _NavItemData(
      iconUrl: 'https://app.codigma.io/api/uploads/assets/26da5033-e965-4b1d-b9c0-626f88a2b10b.svg',
      label: 'Início',
      routeName: 'home',
    ),
    _NavItemData(
      iconUrl: 'https://app.codigma.io/api/uploads/assets/9a69b0a2-4c59-46ce-bfa1-32d7741f167b.svg',
      label: 'Minha Coleção',
      routeName: 'collection',
    ),
    _NavItemData(
      iconUrl: 'https://app.codigma.io/api/uploads/assets/be2f8959-9c7b-4d79-bbba-be60bf8e1fea.svg',
      label: 'Adicionar',
      routeName: 'add',
    ),
    _NavItemData(
      iconUrl: 'https://app.codigma.io/api/uploads/assets/1d9a016f-bbfb-4b9e-86e7-79846bbc93f4.svg',
      label: 'Configurações',
      routeName: 'settings',
    ),
  ];

  void _onActionButtonPressed() {
    setState(() {
      _isButtonPressed = true;
    });
    Future.delayed(const Duration(milliseconds: 120), () {
      setState(() {
        _isButtonPressed = false;
        _isRemoved = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Removido da coleção!")),
      );
    });
  }

  void _onGalleryImageTap(int index) {
    setState(() {
      selectedGalleryIndex = index;
    });
  }

  void _onNavTap(String routeName) {
    // Use standard Navigator (Navigator 1.0). In production, adjust for real navigation.
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text(routeName)),
        body: Center(child: Text('Navigated to $routeName')),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // App background color according to HTML (#211212)
    const backgroundColor = Color(0xFF211212);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Plus Jakarta Sans',
        scaffoldBackgroundColor: backgroundColor,
        primaryColor: const Color(0xFF331A1C),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF331A1C),
          secondary: const Color(0xFFFF7385),
          background: backgroundColor,
        ),
        textTheme: const TextTheme(
          headline6: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            letterSpacing: 0.005,
          ),
          // adjusted for the details
          headline5: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 22,
            letterSpacing: 0.01,
          ),
          subtitle2: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: Color(0xFFC99194),
            fontSize: 15,
            height: 22 / 15,
          ),
          button: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.w700,
            fontSize: 15,
            letterSpacing: 0.02,
            color: Colors.white,
          ),
          caption: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFFC99194),
            letterSpacing: 0.005,
          ),
        ),
      ),
      home: Builder(
        builder: (context) {
          // For responsiveness
          final mq = MediaQuery.of(context);
          return LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth <= 600;
              final isVerySmall = constraints.maxWidth <= 400;
              double headerHeight = isVerySmall
                  ? 48
                  : isMobile
                      ? 56
                      : 56;
              double contentHorizontalPadding = isMobile ? 10 : 20;
              double contentTopPadding = isMobile ? 16 : 24;
              double galleryImageWidth = isMobile
                  ? (constraints.maxWidth * 0.31).clamp(80, 120)
                  : 120;
              double galleryImageHeight = isMobile
                  ? (constraints.maxWidth * 0.27).clamp(0, 92)
                  : 92;
              double actionButtonFontSize = isMobile ? 14 : 15;
              double actionButtonPadding = isMobile ? 12 : 14;
              double actionButtonMarginTop = isMobile ? 18 : 26;
              double modelNameFontSize = isVerySmall
                  ? 18
                  : 22;
              double footerHeight = isVerySmall
                  ? 58
                  : isMobile
                      ? 64
                      : 74;

              return Scaffold(
                backgroundColor: backgroundColor,
                body: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _MiniaturaHeader(
                        height: headerHeight,
                        titleStyle: theme.textTheme.headline6?.copyWith(
                          fontSize: isMobile ? 16 : 18,
                        ),
                        onBack: () {
                          Navigator.of(context).maybePop();
                        },
                        onOptions: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Options tapped"),
                            ),
                          );
                        },
                      ),
                      Expanded(
                        child: Center(
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 600),
                            padding: EdgeInsets.fromLTRB(contentHorizontalPadding, contentTopPadding, contentHorizontalPadding, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _Gallery(
                                  images: _galleryImages,
                                  selectedIndex: selectedGalleryIndex,
                                  width: galleryImageWidth,
                                  height: galleryImageHeight,
                                  onTap: _onGalleryImageTap,
                                ),
                                const SizedBox(height: 20),
                                _Details(
                                  modelName: "Ford Mustang",
                                  modelNameFontSize: modelNameFontSize,
                                  details: _details,
                                  detailStyle: theme.textTheme.subtitle2!,
                                ),
                                SizedBox(height: actionButtonMarginTop),
                                _isRemoved
                                    ? Center(
                                        child: Icon(
                                          Icons.check_circle,
                                          color: theme.colorScheme.secondary,
                                          size: 48,
                                          semanticLabel: "Removed from collection",
                                        ),
                                      )
                                    : _ActionButton(
                                        text: "Remover da Coleção",
                                        pressed: _isButtonPressed,
                                        fontSize: actionButtonFontSize,
                                        padding: actionButtonPadding,
                                        onPressed: _onActionButtonPressed,
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Semantics(
                        container: true,
                        label: "Navigation bar",
                        child: _MiniaturaFooterNavigation(
                          height: footerHeight,
                          navItems: _footerNavItems,
                          onTap: _onNavTap,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/// Header widget (AppBar substitute)
class _MiniaturaHeader extends StatelessWidget {
  final double height;
  final TextStyle? titleStyle;
  final VoidCallback? onBack;
  final VoidCallback? onOptions;

  const _MiniaturaHeader({
    Key? key,
    required this.height,
    this.titleStyle,
    this.onBack,
    this.onOptions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fallback icon asset in case network unavailable.
    return Container(
      height: height,
      color: const Color(0xFF331A1C),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Back icon
          Semantics(
            label: "Back",
            button: true,
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: onBack,
              child: Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                child: Image.network(
                  'https://app.codigma.io/api/uploads/assets/dc3bde45-0486-486b-80ed-3430e72a62e5.svg',
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                  semanticLabel: "Voltar",
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Center(
              child: Text(
                "Detalhes da Miniatura",
                style: titleStyle ??
                    const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      letterSpacing: 0.005,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Options icon
          Semantics(
            label: "Options",
            button: true,
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: onOptions,
              child: Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                child: Image.network(
                  'https://app.codigma.io/api/uploads/assets/0369bb5d-8ae6-441d-975a-a3b1abe9669f.svg',
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                  semanticLabel: "Opções",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Gallery widget with images, showing highlight around selected/first
class _Gallery extends StatelessWidget {
  final List<_MiniaturaGalleryImage> images;
  final int selectedIndex;
  final double width;
  final double height;
  final ValueChanged<int>? onTap;

  const _Gallery({
    Key? key,
    required this.images,
    required this.selectedIndex,
    required this.width,
    required this.height,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Gallery of images',
      child: SizedBox(
        height: height,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(images.length, (i) {
            final image = images[i];
            return Padding(
              padding: EdgeInsets.only(right: i < images.length - 1 ? 12 : 0),
              child: GestureDetector(
                onTap: () => onTap?.call(i),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF331A1C), width: 2),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x21532115),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    color: const Color(0xFF281616),
                  ),
                  child: Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      outline: (i == selectedIndex)
                          ? const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                color: Color(0xFFFF7385),
                                width: 2,
                              ),
                            )
                          : null,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        outline: null,
                        // Use outline outside only for highlight (Flutter workaround below)
                        boxShadow: i == selectedIndex
                            ? [
                                BoxShadow(
                                  color: const Color(0xFFFF7385),
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  offset: const Offset(0, 0),
                                ),
                              ]
                            : [],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          image.url,
                          width: width,
                          height: height,
                          fit: BoxFit.cover,
                          semanticLabel: image.alt,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

/// Details Section
class _Details extends StatelessWidget {
  final String modelName;
  final double modelNameFontSize;
  final List<_ModelDetail> details;
  final TextStyle detailStyle;

  const _Details({
    Key? key,
    required this.modelName,
    required this.modelNameFontSize,
    required this.details,
    required this.detailStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: "Details section",
      child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              modelName,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.w700,
                fontSize: modelNameFontSize,
                letterSpacing: 0.01,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 2),
            ...details.map((d) {
              return Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  "${d.label}: ${d.value}",
                  style: detailStyle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String text;
  final bool pressed;
  final double fontSize;
  final double padding;
  final VoidCallback onPressed;

  const _ActionButton({
    Key? key,
    required this.text,
    required this.pressed,
    required this.fontSize,
    required this.padding,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorNormal = const Color(0xFF472426);
    final colorActive = const Color(0xFF592E31);
    return Semantics(
      button: true,
      label: text,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 460),
        margin: EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
          color: pressed ? colorActive : colorNormal,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0x0AFF6565),
              blurRadius: 18,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onPressed,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: padding),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w700,
                    fontSize: fontSize,
                    letterSpacing: 0.02,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Footer Navigation
class _MiniaturaFooterNavigation extends StatelessWidget {
  final double height;
  final List<_NavItemData> navItems;
  final ValueChanged<String>? onTap;

  const _MiniaturaFooterNavigation({
    super.key,
    required this.height,
    required this.navItems,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        color: Color(0xFF331A1C),
        border: Border(
          top: BorderSide(color: Color(0xFF472426), width: 1.5),
        ),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 450),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: navItems.map((item) {
              return _FooterNavItem(
                iconUrl: item.iconUrl,
                label: item.label,
                onTap: () {
                  onTap?.call(item.routeName);
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

/// Single Navigation Item for Footer
class _FooterNavItem extends StatelessWidget {
  final String iconUrl;
  final String label;
  final VoidCallback onTap;

  const _FooterNavItem({
    Key? key,
    required this.iconUrl,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Semantics(
        selected: false,
        button: true,
        label: label,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  iconUrl,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                  semanticLabel: label,
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFC99194),
                    letterSpacing: 0.005,
                    height: 1.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Model for gallery image.
class _MiniaturaGalleryImage {
  final String url;
  final String alt;
  const _MiniaturaGalleryImage({required this.url, required this.alt});
}

// Model for detail info.
class _ModelDetail {
  final String label;
  final String value;
  const _ModelDetail({required this.label, required this.value});
}

// Model for footer nav item data.
class _NavItemData {
  final String iconUrl;
  final String label;
  final String routeName;
  const _NavItemData({
    required this.iconUrl,
    required this.label,
    required this.routeName,
  });
}