import 'package:catalago_colecionadores/src/core/global/global_context.dart';
import 'package:catalago_colecionadores/src/core/global/global_itens.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/core/ui/widgets/miniaturas_nav_bar.dart';
import 'package:catalago_colecionadores/src/pages/minhacolecao/widgets/filter_item_wiget.dart';
import 'package:catalago_colecionadores/src/pages/minhacolecao/widgets/search_bar_widget.dart';
import 'package:catalago_colecionadores/src/pages/minhacolecao/widgets/view_option_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/database/isar_models/car_collection.dart';
import '../../core/database/isar_service.dart';
import 'widgets/collection_grid.dart';
import 'widgets/collection_list.dart';

// ---------------------
// Main Widget
// ---------------------
class MinhaColecao extends StatefulWidget {
  const MinhaColecao({super.key});

  @override
  State<MinhaColecao> createState() => _MinhaColecaoState();
}

class _MinhaColecaoState extends State<MinhaColecao> {
  int _selectedFilter = -1;

  // Data state
  final IsarService _isarService = IsarService();
  List<CarCollection> _allItems = [];
  List<CarCollection> _displayedItems = [];
  final List<FilterItemData> _filters = GlobalItens.filters;
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
      _displayedItems = cars;
      _isLoading = false;
    });
  }

  Future<void> _performSearch(String query) async {
    if (query.length < 3) {
      setState(() {
        _displayedItems = _allItems;
      });
      return;
    }

    final results = await _isarService.searchCars(query);
    if (results.isEmpty) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Atenção'),
            content: const Text(
              'Dados não encontrados, favor refazer a pesquisa',
            ),
            actions: [
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
      // Keep previous state (do not update _displayedItems to empty)
    } else {
      setState(() {
        _displayedItems = results;
      });
    }
  }

  Future<void> _showCategoryPopup() async {
    // 1. Fetch categories from DB
    final categories = await _isarService.getAllCategories();
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Selecione uma Categoria'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return ListTile(
                  title: Text(category.name),
                  onTap: () {
                    context.pop(); // Close dialog
                    _filterByCategory(category.name);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
                // "Cancel" -> reset filter
                setState(() {
                  _displayedItems = _allItems;
                  _selectedFilter = -1;
                });
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMarcaPopup() async {
    final marcas = await _isarService.getAllMarcas();
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Selecione uma Marca'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: marcas.length,
              itemBuilder: (context, index) {
                final marca = marcas[index];
                return ListTile(
                  title: Text(marca.nome),
                  onTap: () {
                    context.pop();
                    _filterByMarca(marca.nome);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
                setState(() {
                  _displayedItems = _allItems;
                  _selectedFilter = -1;
                });
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _filterByMarca(String marcaName) {
    final filtered = _allItems
        .where((item) => item.marca.toLowerCase() == marcaName.toLowerCase())
        .toList();
    setState(() {
      _displayedItems = filtered;
    });
  }

  void _filterByCategory(String categoryName) {
    final filtered = _allItems
        .where(
          (item) => item.categoria.toLowerCase() == categoryName.toLowerCase(),
        )
        .toList();
    setState(() {
      _displayedItems = filtered;
    });
  }

  void _filterByScale(String scale) {
    final filtered = _allItems
        .where((item) => item.escala.toLowerCase() == scale.toLowerCase())
        .toList();
    setState(() {
      _displayedItems = filtered;
    });
  }

  Future<void> _showScalePopup() async {
    // Extract unique scales from all items
    final scales = _allItems.map((e) => e.escala).toSet().toList();
    // Sort them nicely
    scales.sort(
      (a, b) => a.compareTo(b),
    ); // Simple string sort, can be improved for "1:18" vs "1:4" logic if needed

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Selecione uma Escala'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: scales.length,
              itemBuilder: (context, index) {
                final scale = scales[index];
                return ListTile(
                  title: Text(scale),
                  onTap: () {
                    context.pop();
                    _filterByScale(scale);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
                setState(() {
                  _displayedItems = _allItems;
                  _selectedFilter = -1;
                });
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showSeriePopup() async {
    final series = await _isarService.getAllSeries();
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Selecione uma Serie'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: series.length,
              itemBuilder: (context, index) {
                final serie = series[index];
                return ListTile(
                  title: Text(serie.nome),
                  onTap: () {
                    context.pop();
                    _filterBySerie(serie.nome);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
                setState(() {
                  _displayedItems = _allItems;
                  _selectedFilter = -1;
                });
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _filterBySerie(String serieName) {
    final filtered = _allItems
        .where((item) => item.serie?.toLowerCase() == serieName.toLowerCase())
        .toList();

    if (filtered.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Atenção'),
          content: const Text('Sem itens cadastrados para esta Serie'),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
                // Reset filter check if needed, or just leave as is.
                // User asked to "Cancel" to go back, but this is the "Empty" message.
                // Usually we might want to reset the selected filter index visual if we didn't apply the filter.
                setState(() {
                  _selectedFilter = -1;
                });
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      setState(() {
        _displayedItems = filtered;
      });
    }
  }

  void _handleFilterSelection(int index) {
    setState(() {
      _selectedFilter = index;
    });

    if (index >= 0 && index < _filters.length) {
      if (_filters[index].label == 'Marca') {
        _showMarcaPopup();
      } else if (_filters[index].label == 'Categoria') {
        _showCategoryPopup();
      } else if (_filters[index].label == 'Escala') {
        _showScalePopup();
      } else if (_filters[index].label == 'Serie') {
        _showSeriePopup();
      }
    } else {
      // Reset filter if deselected (index == -1)
      setState(() {
        _displayedItems = _allItems;
      });
    }
  }

  final int _selectedNavIndex = 1;

  void _handleItemTap(CarCollection item) async {
    await context.push('/miniatura_details', extra: item.id);
    _loadData();
  }

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
                                  onTap: () async {
                                    await context.push('/add_car');
                                    _loadData();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SEARCH SECTION
                      const SizedBox(height: 20),
                      Container(
                        padding: _mainPadding(maxWidth),
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SearchBarWidget(
                              backgroundColor:
                                  CatalagoColecionadorTheme.bgInput,
                              iconColor: CatalagoColecionadorTheme
                                  .navBarBackkgroundColor,
                              textColor:
                                  CatalagoColecionadorTheme.blackClaroColor,
                              hint: "Pesquisar",
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z0-9]'),
                                ),
                              ],
                              onChanged: (text) {
                                _performSearch(text);
                              },
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
                              selectedView: _selectedView,
                              onViewModeChanged: (mode) =>
                                  setState(() => _selectedView = mode),
                              onFilterSelected: _handleFilterSelection,
                            ),
                            const SizedBox(height: 10),
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
                                    // COLLECTION GRID
                                    const SizedBox(height: 10),
                                    _isLoading
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : _selectedView == ViewMode.grid
                                        ? CollectionGrid(
                                            items: _displayedItems,
                                            gridCount: gridCount,
                                            surface: CatalagoColecionadorTheme
                                                .bgInput,
                                            brandColor:
                                                CatalagoColecionadorTheme
                                                    .whiteColor,
                                            modelColor:
                                                CatalagoColecionadorTheme
                                                    .navBarBackkgroundColor,
                                            onItemTap: _handleItemTap,
                                          )
                                        : CollectionList(
                                            items: _displayedItems,
                                            surface: CatalagoColecionadorTheme
                                                .bgInput,
                                            brandColor:
                                                CatalagoColecionadorTheme
                                                    .whiteColor,
                                            modelColor:
                                                CatalagoColecionadorTheme
                                                    .navBarBackkgroundColor,
                                            onItemTap: _handleItemTap,
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
                        navHeight: maxWidth < 600 ? 67 : 80,
                        iconSize: maxWidth < 600 ? 22 : 27,
                        labelFontSize: maxWidth < 600 ? 10.6 : 12.2,
                        navItemWidth: maxWidth < 600 ? 76 : 80,
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
