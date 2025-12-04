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
              item.nomeMiniatura.toLowerCase().contains(
                _searchText.toLowerCase(),
              ) ||
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
                                  onTap: () async {
                                    await Navigator.of(
                                      context,
                                    ).pushNamed('/add_car');
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
                            const SizedBox(height: 10),
                            ViewOptionsWidget(
                              selected: _selectedView,
                              onSelect: (mode) =>
                                  setState(() => _selectedView = mode),
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

class _CollectionList extends StatelessWidget {
  const _CollectionList();

  @override
  Widget build(BuildContext context) {
    // Item data
    final items = const [
      {
        "img":
            "https://app.codigma.io/api/uploads/assets/1f6ea58b-e237-4ddf-bdcf-546baa99271c.png",
        "brand": "Hot Wheels",
        "model": "Ford Mustang",
      },
      {
        "img":
            "https://app.codigma.io/api/uploads/assets/7108395f-b606-4a25-9130-e50d55e64f38.png",
        "brand": "Maisto",
        "model": "Chevrolet Camaro",
      },
      {
        "img":
            "https://app.codigma.io/api/uploads/assets/bc34548f-7a50-4a00-b5f3-c3c841002e5e.png",
        "brand": "Matchbox",
        "model": "Volkswagen Beetle",
      },
      {
        "img":
            "https://app.codigma.io/api/uploads/assets/de634606-0b28-4a91-b36d-e540a850ca58.png",
        "brand": "Greenlight",
        "model": "Dodge Charger",
      },
      {
        "img":
            "https://app.codigma.io/api/uploads/assets/e1f750b9-1103-4f57-a3fb-1d6fc4871f3d.png",
        "brand": "Jada Toys",
        "model": "Nissan GT-R",
      },
      {
        "img":
            "https://app.codigma.io/api/uploads/assets/90dc5823-bf28-4e38-b49c-d42063d131b3.png",
        "brand": "Auto World",
        "model": "Porsche 911",
      },
    ];

    // Responsive grid count

    Widget list = ListView.separated(
      padding: const EdgeInsets.only(top: 16),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, __) => SizedBox(height: 8),
      itemBuilder: (context, index) {
        final it = items[index];
        return _CollectionItemRow(
          imgUrl: it['img']!,
          brand: it['brand']!,
          model: it['model']!,
        );
      },
    );

    return AnimatedSwitcher(duration: Duration(milliseconds: 170), child: list);
  }
}

class _CollectionItemCard extends StatelessWidget {
  final String imgUrl;
  final String brand;
  final String model;
  const _CollectionItemCard({
    required this.imgUrl,
    required this.brand,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    const secondaryBg = Color(0xFF472426);
    const textSecondary = Color(0xFFC99194);
    return Semantics(
      label: "$brand: $model",
      child: Material(
        color: secondaryBg,
        borderRadius: BorderRadius.circular(12),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("$brand $model tapped!")));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: Image.network(imgUrl, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 13, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      brand,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.01,
                      ),
                    ),
                    SizedBox(height: 1),
                    Text(
                      model,
                      style: TextStyle(
                        color: textSecondary,
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _CollectionItemRow extends StatelessWidget {
  final String imgUrl;
  final String brand;
  final String model;
  const _CollectionItemRow({
    required this.imgUrl,
    required this.brand,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    const secondaryBg = Color(0xFF472426);
    const textSecondary = Color(0xFFC99194);

    return Semantics(
      label: "$brand: $model",
      child: Material(
        color: secondaryBg,
        borderRadius: BorderRadius.circular(12),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("$brand $model tapped!")));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imgUrl,
                    width: 70,
                    height: 46,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        brand,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 15 ,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.01,
                        ),
                      ),
                      Text(
                        model,
                        style: TextStyle(
                          color: textSecondary,
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
