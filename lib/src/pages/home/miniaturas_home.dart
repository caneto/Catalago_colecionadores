import 'package:catalago_colecionadores/src/core/database/isar_models/category_collection.dart';
import 'package:catalago_colecionadores/src/core/database/isar_service.dart';
import 'package:catalago_colecionadores/src/core/global/global.dart';
import 'package:catalago_colecionadores/src/core/global/global_itens.dart';
import 'package:catalago_colecionadores/src/core/services/shared_preferences_service.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/core/ui/widgets/miniaturas_nav_bar.dart';
import 'package:catalago_colecionadores/src/pages/home/widgets/section_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'widgets/category_item.dart';
import 'widgets/destaque_items_list.dart';
import 'widgets/novidades_items_list.dart';

class MiniaturasHome extends StatefulWidget {
  const MiniaturasHome({super.key});

  @override
  State<MiniaturasHome> createState() => _MiniaturasHomeState();
}

class _MiniaturasHomeState extends State<MiniaturasHome> {
  final _key = GlobalKey<ExpandableFabState>();

  final _searchController = TextEditingController();
  final String _searchValue = '';

  int _selectedNavIndex = 0;

  static const _highlightItems = [
    {'image': 'assets/images/hotwheels.png', 'title': 'Hot Wheels'},
    {'image': 'assets/images/maisto.png', 'title': 'Maisto'},
    {'image': 'assets/images/matchbox.png', 'title': 'Matchbox'},
  ];

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

  void onItemCardTap(String item) {
    if (kDebugMode) {
      print('Item tapped: $item');
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    _selectedNavIndex = 0; // Seta o select para o "Home"

    return Scaffold(
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _key,
        margin: const EdgeInsets.only(bottom: 65),
        // duration: const Duration(milliseconds: 500),
        // distance: 200.0,
        // type: ExpandableFabType.up,
        // pos: ExpandableFabPos.left,
        // childrenOffset: const Offset(0, 20),
        // childrenAnimation: ExpandableFabAnimation.none,
        // fanAngle: 40,
        // openButtonBuilder: RotateFloatingActionButtonBuilder(
        //   child: const Icon(Icons.abc),
        //   fabSize: ExpandableFabSize.large,
        //   foregroundColor: Colors.amber,
        //   backgroundColor: Colors.green,
        //   shape: const CircleBorder(),
        //   angle: 3.14 * 2,
        //   elevation: 5,
        // ),
        // closeButtonBuilder: FloatingActionButtonBuilder(
        //   size: 56,
        //   builder: (BuildContext context, void Function()? onPressed,
        //       Animation<double> progress) {
        //     return IconButton(
        //       onPressed: onPressed,
        //       icon: const Icon(
        //         Icons.check_circle_outline,
        //         size: 40,
        //       ),
        //     );
        //   },
        // ),
        overlayStyle: ExpandableFabOverlayStyle(
          color: Colors.black.withValues(alpha: 0.5),
          blur: 5,
        ),
        onOpen: () {
          debugPrint('onOpen');
        },
        afterOpen: () {
          debugPrint('afterOpen');
        },
        onClose: () {
          debugPrint('onClose');
        },
        afterClose: () {
          debugPrint('afterClose');
        },
        children: [
          FloatingActionButton.small(
            heroTag: null,
            child: const Icon(Icons.add_box_rounded),
            onPressed: () {
              const SnackBar snackBar = SnackBar(
                content: Text("Cadastra carrinho"),
              );
              scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
              context.push('/add_car');
            },
          ),
          FloatingActionButton.small(
            heroTag: null,
            child: const Icon(Icons.add_circle_outline_rounded),
            onPressed: () {
              const SnackBar snackBar = SnackBar(
                content: Text("Cadastro de categoria"),
              );
              scaffoldMessengerKey.currentState?.showSnackBar(snackBar);

              context.push('/category');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (ctx, constraints) {
            final sectionHorizontalPadding = _horizontalPadding(constraints);
            final itemCardWidth = _getItemCardWidth(constraints);
            final itemCardHeight = _getItemCardHeight(constraints);
            final itemImageHeight = _getItemImageHeight(constraints);

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
                                color:
                                    CatalagoColecionadorTheme.blackClaroColor,
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
                                  'Miniaturas',
                                  style: CatalagoColecionadorTheme.titleStyle
                                      .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        letterSpacing: -0.01,
                                        color: CatalagoColecionadorTheme
                                            .whiteColor,
                                      ),
                                ),
                              ),
                              Semantics(
                                label: 'Fecha o app',
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: InkWell(
                                    child: SvgPicture.asset(
                                      'assets/images/turn-off.svg',
                                      height: 32,
                                      width: 32,
                                      semanticsLabel: 'off',
                                      colorFilter: ColorFilter.mode(
                                        CatalagoColecionadorTheme.whiteColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    onTap: () async {
                                      await SharedPreferencesService.remove('is_logged_in');
                                      SystemNavigator.pop();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Destaques
                        SectionWidget(
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
                                'Destaque na Coleção',
                                style: CatalagoColecionadorTheme.textBold
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.25,
                                    ),
                              ),
                            ),
                            HorizontalItemsList(
                              items: _highlightItems,
                              width: itemCardWidth,
                              height: itemCardHeight,
                              imgHeight: itemImageHeight,
                              isScrollable: constraints.maxWidth < 600,
                            ),
                          ],
                        ),
                        // Novidades
                        SectionWidget(
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
                                'Novidades Cadastradas',
                                style: CatalagoColecionadorTheme.textBold
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.25,
                                    ),
                              ),
                            ),
                            NovidadesItemsList(
                              width: 180,
                              height: 220,
                              imgHeight: 120,
                              isScrollable: constraints.maxWidth < 600,
                            ),
                          ],
                        ),
                        // Categories
                        SectionWidget(
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.25,
                                    ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: constraints.maxWidth < 600 ? 2 : 6,
                              ),
                              child: FutureBuilder<List<CategoryCollection>>(
                                future: IsarService().getAllCategories(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  if (snapshot.hasError) {
                                    return const Center(
                                      child: Text(
                                        'Erro ao carregar categorias',
                                      ),
                                    );
                                  }

                                  if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return const Center(
                                      child: Text(
                                        'Nenhuma categoria encontrada',
                                      ),
                                    );
                                  }

                                  final categories = snapshot.data!;

                                  return Wrap(
                                    spacing: constraints.maxWidth < 600
                                        ? 10
                                        : 16,
                                    runSpacing: 8,
                                    alignment: WrapAlignment.start,
                                    children: categories
                                        .map(
                                          (cat) => CategoryItem(
                                            label: cat.name,
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
                                            onTap: onItemCardTap,
                                          ),
                                        )
                                        .toList(),
                                  );
                                },
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
                    child: MiniaturasNavBar(
                      items: GlobalItens.navItems,
                      selectedIndex: _selectedNavIndex,
                      navHeight: constraints.maxWidth < 600 ? 67 : 80,
                      iconSize: constraints.maxWidth < 600 ? 21 : 26,
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
