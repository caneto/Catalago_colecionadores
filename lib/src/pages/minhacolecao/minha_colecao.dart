import 'package:catalago_colecionadores/src/core/global/global_context.dart';
import 'package:catalago_colecionadores/src/core/global/global_itens.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/core/ui/widgets/miniaturas_nav_bar.dart';
import 'package:catalago_colecionadores/src/pages/home/widgets/search_bar_widget.dart';
import 'package:catalago_colecionadores/src/pages/minhacolecao/widgets/filter_item_wiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'helpers/collection_item_data_model.dart';
import 'widgets/collection_grid.dart';

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
    FilterItemData(
      label: 'Escala',
      iconUrl: 'seta_filter.svg',
      hasDropdown: true,
    ),
    FilterItemData(
      label: 'Condição',
      iconUrl: 'seta_filter.svg',
      hasDropdown: true,
    ),
    FilterItemData(label: 'Categoria', hasDropdown: false),
  ];

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

    return Scaffold(
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
                            bottom: BorderSide(
                              color: CatalagoColecionadorTheme.blackClaroColor,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Semantics(
                              header: true,
                              child: Text(
                                'Minha Coleção',
                                style: CatalagoColecionadorTheme.titleStyle
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      letterSpacing: -0.01,
                                      color:
                                          CatalagoColecionadorTheme.whiteColor,
                                    ),
                              ),
                            ),
                            Semantics(
                              label: 'Perfil',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: InkWell(
                                  child: SvgPicture.asset(
                                    'assets/images/estrela.svg',
                                    height: 32,
                                    width: 32,
                                    semanticsLabel: 'X',
                                  ),
                                  onTap: () {
                                    Navigator.of(
                                      context,
                                    ).pushReplacementNamed('/add_car');
                                  },
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SEARCH SECTION
                                    const SizedBox(height: 20),
                                    SearchBarWidget(
                                      backgroundColor:
                                          CatalagoColecionadorTheme.bgInput,
                                      iconColor: CatalagoColecionadorTheme
                                          .navBarBackkgroundColor,
                                      textColor: CatalagoColecionadorTheme
                                          .navBarBackkgroundColor,
                                      hint: "Pesquisar",
                                      onChanged: (text) =>
                                          setState(() => _searchText = text),
                                    ),
                                    // FILTERS
                                    const SizedBox(height: 14),
                                    _AvailableFilters(
                                      isMobile: GlobalContext.isMobile(context),
                                      filters: _filters,
                                      color: CatalagoColecionadorTheme.bgInput,
                                      textColor: CatalagoColecionadorTheme
                                          .navBarBackkgroundColor,
                                      iconColor: CatalagoColecionadorTheme
                                          .navBarBackkgroundColor,
                                      selectedFilter: _selectedFilter,
                                    ),
                                    SizedBox(
                                      height: 47, // ensure space for scroll
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        physics: const BouncingScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (ctx, i) =>
                                            FilterItemWiget(
                                              data: _filters[i],
                                              color: CatalagoColecionadorTheme
                                                  .bgInput,
                                              textColor:
                                                  CatalagoColecionadorTheme
                                                      .navBarBackkgroundColor,
                                              iconColor:
                                                  CatalagoColecionadorTheme
                                                      .navBarBackkgroundColor,
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
                                      surface:
                                          CatalagoColecionadorTheme.bgInput,
                                      brandColor:
                                          CatalagoColecionadorTheme.whiteColor,
                                      modelColor: CatalagoColecionadorTheme
                                          .navBarBackkgroundColor,
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
                        labelFontSize: constraints.maxWidth < 600 ? 10.6 : 12.2,
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

// AVAILABLE FILTERS
class _AvailableFilters extends StatefulWidget {
  final bool isMobile;
  final List<FilterItemData> filters;
  final int selectedFilter;
  final Color color;
  final Color textColor;
  final Color iconColor;

  const _AvailableFilters({
    super.key,
    this.isMobile = false,
    required this.filters,
    required this.selectedFilter,
    required this.color,
    required this.textColor,
    required this.iconColor,
  });

  @override
  State<_AvailableFilters> createState() => _AvailableFiltersState();
}

class _AvailableFiltersState extends State<_AvailableFilters> {
  @override
  Widget build(BuildContext context) {
    const textSecondary = Color(0xFFC99194);
    int selectedFilter = widget.selectedFilter;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          header: true,
          child: Text(
            "Filters",
            style: TextStyle(
              color: textSecondary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: 'Plus Jakarta Sans',
            ),
          ),
        ),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: List.generate(widget.filters.length, (i) {
            return _FilterOption(
              data: widget.filters[i],
              selected: widget.isMobile,
              onTap: () {
                setState(() {
                  selectedFilter = selectedFilter == i ? -1 : i;
                });
              },
              color: widget.color,
              textColor: widget.textColor,
              iconColor: widget.iconColor,
            );
          }),
        ),
        // Use Wrap para permitir múltiplos por linha e quebra automática
        SizedBox(height: 4),
      ],
    );
  }
}

class _FilterOption extends StatelessWidget {
  final FilterItemData data;
  final bool selected;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;
  final Color iconColor;

  const _FilterOption({
    required this.data,
    required this.selected,
    required this.onTap,
    required this.color,
    required this.textColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    const filterBg = Color(0xFF472426);

    return Semantics(
      button: true,
      label: data.label,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Open $data.label filter (Not implemented)"),
            ),
          );
        },
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          curve: Curves.ease,
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
          decoration: BoxDecoration(
            color: selected
                ? color.withValues(alpha: 0.94)
                : color, // Feedback when selected
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize:
                MainAxisSize.min, // deixa a Row ocupar só o necessário
            children: [
              Text(
                data.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
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
