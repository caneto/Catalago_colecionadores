import 'package:catalago_colecionadores/src/core/global/global_context.dart';
import 'package:catalago_colecionadores/src/core/global/global_itens.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/core/ui/widgets/miniaturas_nav_bar.dart';
import 'package:catalago_colecionadores/src/pages/home/widgets/search_bar_widget.dart';
import 'package:catalago_colecionadores/src/pages/minhacolecao/widgets/filter_item_wiget.dart';
import 'package:catalago_colecionadores/src/pages/minhacolecao/widgets/view_option_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/database/isar_models/car_collection.dart';
import '../../core/database/isar_service.dart';
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
  final int _selectedFilter = -1;

  // Data state
  final IsarService _isarService = IsarService();
  List<CarCollection> _allItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final cars = await _isarService.getAllCars();
    setState(() {
      _allItems = cars;
      _isLoading = false;
    });
  }

  List<CarCollection> get _filteredItems {
    if (_searchText.trim().isEmpty) return _allItems;
    return _allItems
        .where(
          (item) =>
              item.marca.toLowerCase().contains(_searchText.toLowerCase()) ||
              item.nomeMiniatura.toLowerCase().contains(_searchText.toLowerCase()) ||
              item.modelo.toLowerCase().contains(_searchText.toLowerCase()),
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

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 480;

  ViewMode _selectedView = ViewMode.grid;

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
                                          .blackClaroColor,
                                      hint: "Pesquisar",
                                      onChanged: (text) =>
                                          setState(() => _searchText = text),
                                    ),
                                    // FILTERS
                                    const SizedBox(height: 14),
                                    FilterItemWidget(
                                      isMobile: GlobalContext.isMobile(context),
                                      filters: _filters,
                                      color: CatalagoColecionadorTheme.bgInput,
                                      textColor: CatalagoColecionadorTheme
                                          .navBarBackkgroundColor,
                                      iconColor: CatalagoColecionadorTheme
                                          .navBarBackkgroundColor,
                                      selectedFilter: _selectedFilter,
                                    ),
                                    // COLLECTION GRID
                                    const SizedBox(height: 10),
                                    ViewOptionsWidget(
                                      selected: _selectedView,
                                      onSelect: (mode) =>
                                          setState(() => _selectedView = mode),
                                      isMobile: isMobile(context),
                                    ),
                                    const SizedBox(height: 10),
                                    _isLoading
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : CollectionGrid(
                                            items: _filteredItems,
                                            gridCount: gridCount,
                                            surface: CatalagoColecionadorTheme
                                                .bgInput,
                                            brandColor:
                                                CatalagoColecionadorTheme
                                                    .whiteColor,
                                            modelColor:
                                                CatalagoColecionadorTheme
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

