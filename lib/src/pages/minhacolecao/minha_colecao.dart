import 'package:catalago_colecionadores/src/core/global/global_itens.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/core/ui/widgets/miniaturas_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'helpers/collection_item_data_model.dart';
import 'widgets/collection_grid.dart';


class FooterNavItemData {
  final String iconUrl;
  final String label;

  const FooterNavItemData({required this.iconUrl, required this.label});
}

// ---------------------
// Main Widget
// ---------------------
class MinhaColecao extends StatefulWidget {
  const MinhaColecao({super.key});

  @override
  State<MinhaColecao> createState() => _MinhaColecaoState();
}

class _MinhaColecaoState extends State<MinhaColecao> {
  // Search state
  String _searchText = '';

  // Dummy filter state (in production, adjust later)
  int _selectedFilter = -1;

  // Dummy collection items (add more for grid fill as in provided HTML)
  List<CollectionItemData> get _allItems => const [
    CollectionItemData(
      imageUrl:
          'https://app.codigma.io/api/uploads/assets/a6efef15-89ac-4614-8efc-c0285240055c.png',
      brand: 'Hot Wheels',
      model: 'Ford Mustang',
    ),
    CollectionItemData(
      imageUrl:
          'https://app.codigma.io/api/uploads/assets/9d17151b-2f3e-40dd-a43d-a07519aa8873.png',
      brand: 'Maisto',
      model: 'Chevrolet Camaro',
    ),
    CollectionItemData(
      imageUrl:
          'https://app.codigma.io/api/uploads/assets/a6efef15-89ac-4614-8efc-c0285240055c.png',
      brand: 'Hot Wheels',
      model: 'Ford Mustang',
    ),
    CollectionItemData(
      imageUrl:
          'https://app.codigma.io/api/uploads/assets/9d17151b-2f3e-40dd-a43d-a07519aa8873.png',
      brand: 'Maisto',
      model: 'Chevrolet Camaro',
    ),
  ];

  List<CollectionItemData> get _filteredItems {
    if (_searchText.trim().isEmpty) return _allItems;
    return _allItems
        .where(
          (item) =>
              item.brand.toLowerCase().contains(_searchText.toLowerCase()) ||
              item.model.toLowerCase().contains(_searchText.toLowerCase()),
        )
        .toList();
  }

  // Filter options
  static const List<FilterItemData> _filters = [
    FilterItemData(
      label: 'Marca',
      iconUrl: 'seta_filter.svg',
      hasDropdown: true,
    ),
    FilterItemData(
      label: 'Modelo',
      iconUrl: 'seta_filter.svg',
      hasDropdown: true,
    ),
    FilterItemData(label: 'Ano', iconUrl: 'seta_filter.svg', hasDropdown: true),
    FilterItemData(label: 'Categoria', hasDropdown: false),
  ];



  // Colors mapped to the CSS variables
  static const Color _bgMain = Color(0xFF211212);
  static const Color _surface = Color(0xFF472426);
  static const Color _surfaceAlt = Color(0xFF331A1C);
  static const Color _brand = Color(0xFFC99194);
  static const Color _divider = Color(0xFF472426);
  static const Color _white = Colors.white;

  final int _selectedNavIndex = 1;

  // Responsive: grid columns
  int _calculateGridCount(double width) {
    if (width >= 760) return 4;
    if (width >= 600) return 3;
    return 2;
  }

  // Responsive: padding for main content
  EdgeInsets _mainPadding(double maxWidth) {
    if (maxWidth >= 600) return EdgeInsets.zero;
    return const EdgeInsets.symmetric(horizontal: 18);
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    // Use theme data to force light mode colors
    final baseTextTheme = Theme.of(context).textTheme.apply(
      fontFamily: 'Plus Jakarta Sans',
      bodyColor: _white,
      displayColor: _white,
    );

    return Scaffold(
      //backgroundColor: _bgMain,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final gridCount = _calculateGridCount(maxWidth);

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
                  Column(
                    children: [
                      // HEADER
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
                            bottom: BorderSide(color: _divider, width: 1),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Semantics(
                              header: true,
                              child: Text(
                                'Minha Coleção',
                                style: baseTextTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  letterSpacing: -0.01,
                                  color: _white,
                                ),
                              ),
                            ),
                            Semantics(
                              label: 'Perfil',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: SvgPicture.asset(
                                  'assets/images/estrela.svg', // Path to your SVG asset
                                  height: 32,
                                  width: 32,
                                  semanticsLabel: 'X',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Body Main (search, filters, grid) - scrollable
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Container(
                                padding: _mainPadding(maxWidth),
                                constraints: const BoxConstraints(
                                  maxWidth: 600,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    // SEARCH SECTION
                                    const SizedBox(height: 20),
                                    _SearchBar(
                                      backgroundColor: _surface,
                                      iconColor: _brand,
                                      textColor: _brand,
                                      hint: "Pesquisar",
                                      onChanged: (text) =>
                                          setState(() => _searchText = text),
                                    ),
                                    // FILTERS
                                    const SizedBox(height: 14),
                                    SizedBox(
                                      height: 47, // ensure space for scroll
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        physics:
                                            const BouncingScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (ctx, i) => _FilterItem(
                                          data: _filters[i],
                                          color: _surface,
                                          textColor: _white,
                                          iconColor: _brand,
                                          selected: i == _selectedFilter,
                                          onTap: () {
                                            setState(() {
                                              _selectedFilter =
                                                  _selectedFilter == i
                                                  ? -1
                                                  : i;
                                            });
                                          },
                                        ),
                                        separatorBuilder: (ctx, i) =>
                                            const SizedBox(width: 12),
                                        itemCount: _filters.length,
                                      ),
                                    ),
                                    // COLLECTION GRID
                                    const SizedBox(height: 16),
                                    CollectionGrid(
                                      items: _filteredItems,
                                      gridCount: gridCount,
                                      surface: _surface,
                                      brandColor: _white,
                                      modelColor: _brand,
                                    ),
                                    const SizedBox(height: 24),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // FOOTER
                      MiniaturasNavBar(
                        items: GlobalItens.navItems,
                        selectedIndex: _selectedNavIndex,
                        navHeight: constraints.maxWidth < 600 ? 67 : 80,
                        iconSize: constraints.maxWidth < 600 ? 22 : 27,
                        labelFontSize: constraints.maxWidth < 600
                            ? 10.6
                            : 12.2,
                        navItemWidth: constraints.maxWidth < 600 ? 76 : 80,
                      ),
                    ],
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

// -------------
// SearchBar
// -------------

class _SearchBar extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;
  final String hint;
  final ValueChanged<String> onChanged;

  const _SearchBar({
    required this.backgroundColor,
    required this.iconColor,
    required this.textColor,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Mulit-row text field not required here; single-line suffices
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(9),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Row(
        children: [
          SizedBox(
            height: 22,
            width: 22,
            child: SvgPicture.asset(
              'assets/images/lupa.svg', // Path to your SVG asset
              semanticsLabel: 'Search Icon',
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: TextField(
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Color(0xFFC99194),
                letterSpacing: 0.01,
                height: 1.3,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(
                  color: textColor.withOpacity(0.72),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  letterSpacing: 0.01,
                ),
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: onChanged,
              enableSuggestions: false,
              autocorrect: false,
            ),
          ),
        ],
      ),
    );
  }
}

// -------------
// FilterItem
// -------------

class _FilterItem extends StatelessWidget {
  final FilterItemData data;
  final bool selected;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;
  final Color iconColor;

  const _FilterItem({
    required this.data,
    required this.selected,
    required this.onTap,
    required this.color,
    required this.textColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: data.label,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        splashColor: const Color(0x11C99194),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          curve: Curves.ease,
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
          decoration: BoxDecoration(
            color: selected
                ? color.withOpacity(0.94)
                : color, // Feedback when selected
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                data.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                  letterSpacing: -0.01,
                ),
              ),
              if (data.iconUrl != null) ...[
                const SizedBox(width: 10),
                SizedBox(
                  height: 18,
                  width: 18,
                  child: SvgPicture.asset(
                    'assets/images/seta_filter.svg', // Path to your SVG asset
                    semanticsLabel: 'X',
                  ), //Image.network(data.iconUrl!, fit: BoxFit.contain),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

