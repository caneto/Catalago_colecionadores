import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ListaDeDesejosPage extends StatefulWidget {
  const ListaDeDesejosPage({super.key});

  @override
  State<ListaDeDesejosPage> createState() => _ListaDeDesejosPageState();
}

class WishlistItemData {
  final String imageUrl;
  final String title;
  final String brand;

  const WishlistItemData({
    required this.imageUrl,
    required this.title,
    required this.brand,
  });
}

class _ListaDeDesejosPageState extends State<ListaDeDesejosPage> {
  // Mock data matching the design
  final List<WishlistItemData> _items = [
    WishlistItemData(
      imageUrl:
          'https://app.codigma.io/api/uploads/assets/02721239-0697-4f9b-8590-1703f5663e1b.png', // Placeholder
      title: 'Porsche 911 GT3 RS',
      brand: 'Maisto',
    ),
    WishlistItemData(
      imageUrl:
          'https://app.codigma.io/api/uploads/assets/417db90e-ca52-4d69-9429-39eb2936e6bb.png', // Placeholder
      title: '\'65 Ford Mustang',
      brand: 'Hot Wheels',
    ),
    WishlistItemData(
      imageUrl:
          'https://app.codigma.io/api/uploads/assets/02a018f5-6746-45ff-9325-d0d23fcd521e.png', // Placeholder
      title: 'Nissan Skyline GTR',
      brand: 'Hot Wheels',
    ),
    WishlistItemData(
      imageUrl:
          'https://app.codigma.io/api/uploads/assets/02721239-0697-4f9b-8590-1703f5663e1b.png', // Placeholder
      title: 'Volkswagen Beetle',
      brand: 'Maisto',
    ),
    WishlistItemData(
      imageUrl:
          'https://app.codigma.io/api/uploads/assets/417db90e-ca52-4d69-9429-39eb2936e6bb.png', // Placeholder
      title: 'Lamborghini Sián',
      brand: 'Maisto',
    ),
    WishlistItemData(
      imageUrl:
          'https://app.codigma.io/api/uploads/assets/02a018f5-6746-45ff-9325-d0d23fcd521e.png', // Placeholder
      title: '\'69 Chevrolet Camaro',
      brand: 'Hot Wheels',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints(minHeight: sizeOf.height),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(R.ASSETS_IMAGES_CAPA_START_PNG),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              // Header
              _buildHeader(context),
              const SizedBox(height: 24),
              // Search Bar
              _buildSearchBar(),
              const SizedBox(height: 16),
              // Filters Row
              Row(
                children: [
                  Expanded(
                    child: _buildFilterButton(
                      icon: Icons.filter_list,
                      label: 'Filtros',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildFilterButton(
                      icon: Icons.sort,
                      label: 'Ordenar',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Grid Content
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.65, // Adjust based on card content
                  ),
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return _buildGridItem(_items[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
        ),
        const Text(
          'Lista de Desejos',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add, color: Colors.white),
          onPressed: () {
            // Action to add new item
          },
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E2329), // Darker search background
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF2C323B)),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: 'Pesquisar na lista...',
          hintStyle: TextStyle(color: Color(0xFF7A8391)),
          prefixIcon: Icon(Icons.search, color: Color(0xFF7A8391)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildFilterButton({required IconData icon, required String label}) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF1E2329),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white70, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(WishlistItemData item) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(
          0xFF111418,
        ), // Card background matching main background or slightly different
        // In the image, cards seem to have no distinct background color but visually separated?
        // Actually, let's look closer. It seems like standard dark cards.
        // Let's us a slightly lighter color for the card or keep it transparent if the image implies it.
        // The image shows cards with a dark background, maybe #111418 or #0D1014.
        // Let's stick with a distinct card background for clarity.
        border: Border.all(color: const Color(0xFF222831)),
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          Expanded(
            flex: 3, // Give image more space
            child: Container(
              color: const Color(0xFF1A1D23), // Placeholder background
              width: double.infinity,
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.broken_image, color: Colors.white54),
                ),
              ),
            ),
          ),
          // Info Section
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  item.brand,
                  style: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 12),
                // Actions
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFF133663,
                          ), // Dark blue btn
                          foregroundColor: const Color(
                            0xFF1976D2,
                          ), // Lighter blue text? No, standard blue.
                          // Image shows Blue background, White/Light Blue text "Mover"
                          // Let's try to match the "Mover" button style
                          // It looks like a dark blue container with blue text
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: const Size(0, 36),
                        ),
                        child: const Text(
                          'Mover',
                          style: TextStyle(
                            color: Color(0xFF42A5F5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E2329),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFF333A45)),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Color(0xFF9CA3AF),
                          size: 20,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
