import 'package:catalago_colecionadores/src/ui/core/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/ui/core/theme/resource.dart';
import 'package:catalago_colecionadores/src/ui/core/widgets/nav_bar_item.dart';
import 'package:flutter/material.dart';

import 'widgets/category_item.dart';

class MiniaturasHome extends StatefulWidget {
  const MiniaturasHome({super.key});

  @override
  State<MiniaturasHome> createState() => _MiniaturasHomeState();
}

class _MiniaturasHomeState extends State<MiniaturasHome> {
  final _searchController = TextEditingController();
  String _searchValue = '';

  int _selectedNavIndex = 0;

  static const _highlightItems = [
    {
      'image':
          'https://app.codigma.io/api/uploads/assets/575b54c9-d5e8-4d5c-b15d-eea53b6ad92b.png',
      'title': 'Hot Wheels',
    },
    {
      'image':
          'https://app.codigma.io/api/uploads/assets/89618186-6249-4117-baf5-db54a3a371f4.png',
      'title': 'Maisto',
    },
    {
      'image':
          'https://app.codigma.io/api/uploads/assets/c1ff9fab-2526-4c27-a48f-ce40587f0171.png',
      'title': 'Matchbox',
    },
  ];

  static const _newArrivals = [
    {
      'image':
          'https://app.codigma.io/api/uploads/assets/21c2e05e-ca38-48a2-9604-017590e8e8b7.png',
      'title': 'Hot Wheels',
    },
    {
      'image':
          'https://app.codigma.io/api/uploads/assets/a6ef14bb-1ce2-4bd4-ab14-bc6f8cc7bdbc.png',
      'title': 'Maisto',
    },
    {
      'image':
          'https://app.codigma.io/api/uploads/assets/5221c9e6-382b-43ae-b0ef-b7315b0bfdb5.png',
      'title': 'Matchbox',
    },
  ];

  static const _categories = [
    'Cars',
    'Motorcycles',
    'Airplanes',
    'Trucks',
    'Boats',
    'Others',
  ];

  static const _navItems = [
    {'iconLogo': 'home.svg', 'label': 'Home'},
    {'iconLogo': 'minhacolecao.svg', 'label': 'Minha Coleção'},
    {'iconLogo': 'estrela.svg', 'label': 'Adicionar'},
    {'iconLogo': 'engrenagem.svg', 'label': 'Configuração'},
  ];

  // Used for highlighting nav items
  void _onNavTapped(int idx) {
    if (idx == _selectedNavIndex) return;
    setState(() {
      _selectedNavIndex = idx;
    });
    // Place navigation logic here
    // Example: Navigator.push(context, ...), or any other route
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Responsive paddings based on constraints
  EdgeInsets _horizontalPadding(BoxConstraints constraints) {
    if (constraints.maxWidth < 400) {
      return const EdgeInsets.symmetric(horizontal: 4.0);
    } else if (constraints.maxWidth < 600) {
      return const EdgeInsets.symmetric(horizontal: 10.0);
    }
    return const EdgeInsets.symmetric(horizontal: 24.0);
  }

  double _getItemCardWidth(BoxConstraints constraints) {
    if (constraints.maxWidth < 600) {
      return 142;
    }
    return 168;
  }

  double _getItemCardHeight(BoxConstraints constraints) {
    if (constraints.maxWidth < 600) {
      return 180;
    }
    return 200;
  }

  double _getItemImageHeight(BoxConstraints constraints) {
    if (constraints.maxWidth < 600) {
      return 105;
    }
    return 120;
  }

  double _getSectionTitleFontSize(BoxConstraints constraints) {
    if (constraints.maxWidth < 600) {
      return 18;
    }
    return 22;
  }

  double _headerTitleFontSize(BoxConstraints constraints) {
    if (constraints.maxWidth < 600) {
      return 18;
    }
    return 20;
  }

  EdgeInsets _searchBarMargin(BoxConstraints constraints) {
    if (constraints.maxWidth < 400) {
      return const EdgeInsets.only(right: 6.0, top: 10.0);
    } else if (constraints.maxWidth < 600) {
      return const EdgeInsets.only(right: 10.0, top: 10.0);
    }
    return const EdgeInsets.only(right: 24.0, top: 12.0);
  }

  double _searchBarMaxWidth(BoxConstraints constraints) {
    if (constraints.maxWidth < 600) {
      return 175;
    }
    return 250;
  }

  double _searchBarMinWidth(BoxConstraints constraints) {
    if (constraints.maxWidth < 600) {
      return 100;
    }
    return 224;
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      //backgroundColor: const Color(0xFF211212),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (ctx, constraints) {
            final screenWidth = MediaQuery.of(context).size.width;
            // Calculate responsive parameters
            final sectionHorizontalPadding = _horizontalPadding(constraints);
            final itemCardWidth = _getItemCardWidth(constraints);
            final itemCardHeight = _getItemCardHeight(constraints);
            final itemImageHeight = _getItemImageHeight(constraints);
            final sectionTitleFontSize = _getSectionTitleFontSize(constraints);
            final headerTitleFontSize = _headerTitleFontSize(constraints);
            final searchBarMargin = _searchBarMargin(constraints);
            final searchBarMaxWidth = _searchBarMaxWidth(constraints);
            final searchBarMinWidth = _searchBarMinWidth(constraints);

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
                  SingleChildScrollView(
                    padding: EdgeInsets.only(
                      bottom: constraints.maxWidth < 600 ? 80 : 80,
                    ),
                    // For nav bar space
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Header
                        Padding(
                          padding: EdgeInsets.only(
                            top: constraints.maxWidth < 600 ? 0 : 8,
                            left: constraints.maxWidth < 400
                                ? 0
                                : constraints.maxWidth < 600
                                ? 0
                                : 24,
                            right: constraints.maxWidth < 400
                                ? 0
                                : constraints.maxWidth < 600
                                ? 0
                                : 0,
                            bottom: constraints.maxWidth < 600 ? 8 : 16,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Title
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: constraints.maxWidth < 600 ? 12 : 24,
                                    top: constraints.maxWidth < 600 ? 10 : 12,
                                  ),
                                  child: Text(
                                    'Miniaturas',
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontWeight: FontWeight.w700,
                                      fontSize: headerTitleFontSize,
                                      color: Colors.white,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                ),
                              ),
                              // Search Bar
                              Container(
                                margin: searchBarMargin,
                                constraints: BoxConstraints(
                                  maxWidth: searchBarMaxWidth,
                                  minWidth: searchBarMinWidth,
                                ),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    //color: const Color(0xFF472426),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 5,
                                          right: 8,
                                        ),
                                        child: Image.network(
                                          'https://app.codigma.io/api/uploads/assets/c46ff67b-2d78-4c94-afc4-6de1a1434218.svg',
                                          width: constraints.maxWidth < 600
                                              ? 18
                                              : 20,
                                          height: constraints.maxWidth < 600
                                              ? 18
                                              : 20,
                                          color: const Color(0xFFC99194),
                                          errorBuilder: (c, _, __) => Icon(
                                            Icons.search,
                                            color: const Color(0xFFC99194),
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller: _searchController,
                                          onChanged: (val) {
                                            setState(() => _searchValue = val);
                                          },
                                          style: TextStyle(
                                            color: const Color(0xFFC99194),
                                            fontSize: constraints.maxWidth < 600
                                                ? 14
                                                : 16,
                                            fontWeight: FontWeight.w400,
                                            //fontFamily: 'Plus Jakarta Sans',
                                            letterSpacing: .1,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.zero,
                                            isDense: true,
                                            border: InputBorder.none,
                                            hintText: 'Search miniatures',
                                            hintStyle: TextStyle(
                                              color: const Color(
                                                0xFFC99194,
                                              ).withAlpha(3),
                                            ),
                                            prefixIconConstraints:
                                                BoxConstraints.tightFor(
                                                  width: 0,
                                                ),
                                          ),
                                          cursorColor: const Color(0xFFC99194),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Destaques
                        _Section(
                          //background: const Color(0xFF331A1C),
                          borderColor: CatalagoColecionadorTheme.lineDividColor,
                          horizontalPadding: sectionHorizontalPadding,
                          verticalPadding: constraints.maxWidth < 600
                              ? const EdgeInsets.only(top: 14, bottom: 10)
                              : const EdgeInsets.only(top: 24, bottom: 18),
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: constraints.maxWidth < 600 ? 11 : 16,
                              ),
                              child: Text(
                                'Destaques',
                                style: CatalagoColecionadorTheme.textBold
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: sectionTitleFontSize,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.25,
                                    ),
                              ),
                            ),
                            _HorizontalItemsList(
                              items: _highlightItems,
                              width: itemCardWidth,
                              height: itemCardHeight,
                              imgHeight: itemImageHeight,
                              isScrollable: constraints.maxWidth < 600,
                            ),
                          ],
                        ),
                        // Novidades
                        _Section(
                          //background: const Color(0xFF331A1C),
                          borderColor: CatalagoColecionadorTheme.lineDividColor,
                          horizontalPadding: sectionHorizontalPadding,
                          verticalPadding: constraints.maxWidth < 600
                              ? const EdgeInsets.only(top: 14, bottom: 10)
                              : const EdgeInsets.only(top: 24, bottom: 18),
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: constraints.maxWidth < 600 ? 11 : 16,
                              ),
                              child: Text(
                                'Novidades',
                                style: CatalagoColecionadorTheme.textBold
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: sectionTitleFontSize,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.25,
                                    ),
                              ),
                            ),
                            _HorizontalItemsList(
                              items: _newArrivals,
                              width: itemCardWidth,
                              height: itemCardHeight,
                              imgHeight: itemImageHeight,
                              isScrollable: constraints.maxWidth < 600,
                            ),
                          ],
                        ),
                        // Categories
                        _Section(
                          //background: const Color(0xFF331A1C),
                          borderColor: CatalagoColecionadorTheme.lineDividColor,
                          horizontalPadding: sectionHorizontalPadding,
                          verticalPadding: constraints.maxWidth < 600
                              ? const EdgeInsets.only(top: 14, bottom: 10)
                              : const EdgeInsets.only(top: 24, bottom: 18),
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: constraints.maxWidth < 600 ? 11 : 16,
                              ),
                              child: Text(
                                'Categorias',
                                style: CatalagoColecionadorTheme.textBold
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: sectionTitleFontSize,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.25,
                                    ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: constraints.maxWidth < 600 ? 2 : 6,
                              ),
                              child: Wrap(
                                spacing: constraints.maxWidth < 600 ? 10 : 16,
                                runSpacing: 8,
                                alignment: WrapAlignment.start,
                                children: _categories
                                    .map(
                                      (cat) => CategoryItem(
                                        label: cat,
                                        fontSize: constraints.maxWidth < 600
                                            ? 13
                                            : 15,
                                        padding: constraints.maxWidth < 600
                                            ? const EdgeInsets.symmetric(
                                                horizontal: 14,
                                                vertical: 7,
                                              )
                                            : const EdgeInsets.symmetric(
                                                horizontal: 24,
                                                vertical: 8,
                                              ),
                                        minWidth: constraints.maxWidth < 600
                                            ? 50
                                            : 70,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: constraints.maxWidth < 600 ? 85 : 100,
                        ), // So content isn't behind nav bar
                      ],
                    ),
                  ),
                  // Bottom nav bar
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: _MiniaturasNavBar(
                      items: _navItems,
                      selectedIndex: _selectedNavIndex,
                      onItemTap: _onNavTapped,
                      navHeight: constraints.maxWidth < 600 ? 67 : 80,
                      iconSize: constraints.maxWidth < 600 ? 22 : 27,
                      labelFontSize: constraints.maxWidth < 600 ? 10.6 : 12.2,
                      navItemWidth: constraints.maxWidth < 600 ? 76 : 80,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  //final Color background;
  final Color borderColor;
  final EdgeInsets horizontalPadding;
  final EdgeInsets verticalPadding;
  final List<Widget> children;

  const _Section({
    //required this.background,
    required this.borderColor,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: background,
      padding: horizontalPadding.add(verticalPadding),
      width: double.infinity,
      decoration: BoxDecoration(
        //color: background,
        border: Border(top: BorderSide(color: borderColor, width: 1.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class _HorizontalItemsList extends StatelessWidget {
  final List<Map<String, String>> items;
  final double width;
  final double height;
  final double imgHeight;
  final bool isScrollable;

  const _HorizontalItemsList({
    required this.items,
    required this.width,
    required this.height,
    required this.imgHeight,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    final gap = isScrollable ? 8.0 : 16.0;

    Widget list = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < items.length; i++) ...[
          _ItemCard(
            imageUrl: items[i]['image']!,
            title: items[i]['title']!,
            width: width,
            height: height,
            imageHeight: imgHeight,
          ),
          if (i != items.length - 1) SizedBox(width: gap),
        ],
      ],
    );

    if (isScrollable) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: list,
        ),
      );
    }
    return Padding(padding: const EdgeInsets.only(bottom: 4.0), child: list);
  }
}

class _ItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double width;
  final double height;
  final double imageHeight;

  const _ItemCard({
    required this.imageUrl,
    required this.title,
    required this.width,
    required this.height,
    required this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: title,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: CatalagoColecionadorTheme.cardItemAndImageColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              blurRadius: 0,
              spreadRadius: 0,
              color: Colors.transparent,
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.network(
                  imageUrl,
                  width: width,
                  height: imageHeight,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, _, __) => Container(
                    height: imageHeight,
                    color: const Color(0xFF332022),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.broken_image_outlined,
                      color: Colors.white24,
                      size: 38,
                    ),
                  ),
                  loadingBuilder: (ctx, child, progress) => progress == null
                      ? child
                      : Container(
                          height: imageHeight,
                          color: const Color(0xFF332022),
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white24,
                            ),
                            strokeWidth: 2.1,
                          ),
                        ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: CatalagoColecionadorTheme.cardItemAndImageColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                padding: const EdgeInsets.only(top: 12, bottom: 11),
                alignment: Alignment.center,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: CatalagoColecionadorTheme.textBold.copyWith(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.07,
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

class _MiniaturasNavBar extends StatelessWidget {
  final List<Map<String, String>> items;
  final int selectedIndex;
  final void Function(int) onItemTap;
  final double navHeight;
  final double iconSize;
  final double labelFontSize;
  final double navItemWidth;

  const _MiniaturasNavBar({
    required this.items,
    required this.selectedIndex,
    required this.onItemTap,
    required this.navHeight,
    required this.iconSize,
    required this.labelFontSize,
    required this.navItemWidth,
  });

  @override
  Widget build(BuildContext context) {
    // The nav bar max width, for mobile layout, is 480px
    final maxNavWidth = 480.0;
    return Material(
      elevation: 25,
      color: CatalagoColecionadorTheme.navBarBackkgroundColor,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: CatalagoColecionadorTheme.navBarBoxColor,
              width: 1,
            ),
          ),
        ),
        height: navHeight,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxNavWidth),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items
                .asMap()
                .entries
                .map(
                  (e) => NavBarItem(
                    isSelected: selectedIndex == e.key,
                    iconLogo: e.value['iconLogo']!,
                    label: e.value['label']!,
                    onTap: () => onItemTap(e.key),
                    iconSize: iconSize,
                    labelFontSize: labelFontSize,
                    width: navItemWidth,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
