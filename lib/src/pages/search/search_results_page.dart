import 'package:catalago_colecionadores/src/core/global/global_itens.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/core/ui/widgets/miniaturas_nav_bar.dart';
import 'package:catalago_colecionadores/src/pages/search/widgets/search_result_card.dart';
import 'package:flutter/material.dart';

import '../../core/ui/widgets/header_section_widget.dart';

final int _selectedNavIndex = 3;

class SearchResultsPage extends StatefulWidget {
  const SearchResultsPage({super.key});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = "Nissan Skyline";
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        child: HeaderSectionWidget(textHeader: 'Pesquisas'),
                      ),
                      const SizedBox(height: 16),
                      // Search Bar
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF242E47),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _searchController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                ),
                                onPressed: () => _searchController.clear(),
                              ),
                              hintText: 'Pesquisar...',
                              hintStyle: const TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Result Count
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            '3 RESULTADOS ENCONTRADOS',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // List
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ListView(
                            children: [
                              SearchResultCard(
                                title: 'Nissan Skyline GT-R (R34)',
                                year: '2023',
                                series: 'HW J-Imports',
                                colorName: 'Azul Metálico',
                                colorValue: Colors.blue,
                                imageUrl:
                                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png', // Replace with car image if available or keep placeholder logic
                                isNew: true,
                                onCollectionTap: () {},
                                onFavoriteTap: () {},
                                onDetailsTap: () {},
                              ),
                              SearchResultCard(
                                title: 'Bone Shaker',
                                year: '2021',
                                series: 'Rod Squad',
                                colorName: 'Preto Matte',
                                colorValue: Colors.black,
                                // imageUrl: '...', // leaving null to test placeholder
                                isInCollection: true,
                                onCollectionTap: () {},
                                onFavoriteTap: () {},
                                onDetailsTap: () {},
                              ),
                              SearchResultCard(
                                title: "'69 Chevy Camaro",
                                year: '2022',
                                series: 'Muscle Mania',
                                colorName: 'Laranja Solar',
                                colorValue: Colors.orange,
                                isFavorite: true,
                                // imageUrl: '...',
                                onCollectionTap: () {},
                                onFavoriteTap: () {},
                                onDetailsTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
