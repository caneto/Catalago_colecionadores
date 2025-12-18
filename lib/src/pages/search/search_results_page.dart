import 'package:catalago_colecionadores/src/pages/search/widgets/search_result_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFF0F1724), // Approx dark background
      appBar: AppBar(
        title: const Text(
          'Resultados da Pesquisa',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Montserrat',
          ),
        ),
        backgroundColor:
            Colors.transparent, // Transparent to blend with background
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home'); // Fallback
            }
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF242E47),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
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
            const SizedBox(height: 16),
            // Result Count
            const Text(
              '3 RESULTADOS ENCONTRADOS',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 16),
            // List
            Expanded(
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
          ],
        ),
      ),
    );
  }
}
