// File: WishlistPage.dart
import 'package:flutter/material.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class WishlistItemData {
  final String imageUrl;
  final String title;
  final String year;
  final String brand;

  const WishlistItemData({
    required this.imageUrl,
    required this.title,
    required this.year,
    required this.brand,
  });
}

class _WishlistPageState extends State<WishlistPage> {
  final List<WishlistItemData> _wishlistItems = [
    WishlistItemData(
      imageUrl:
          'https://app.codigma.io/api/uploads/assets/02721239-0697-4f9b-8590-1703f5663e1b.png',
      title: 'Ford Mustang',
      year: '2023',
      brand: 'Hot Wheels',
    ),
    WishlistItemData(
      imageUrl:
          'https://app.codigma.io/api/uploads/assets/417db90e-ca52-4d69-9429-39eb2936e6bb.png',
      title: 'Chevrolet Camaro',
      year: '2023',
      brand: 'Maisto',
    ),
    WishlistItemData(
      imageUrl:
          'https://app.codigma.io/api/uploads/assets/02a018f5-6746-45ff-9325-d0d23fcd521e.png',
      title: 'Volkswagen Beetle',
      year: '2023',
      brand: 'Matchbox',
    ),
  ];

  void _onSearchTap() {
    // No-op, show snack bar (demo)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Search tapped!"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final media = MediaQuery.of(context);
        return Scaffold(
          backgroundColor: const Color(0xFF211212),
          body: LayoutBuilder(
            builder: (context, constraints) {
              // Responsiveness based on width
              double maxContainerWidth = 480;
              double horizontalPadding = 16;
              double wishlistItemImageSize = 104;
              double detailsPadding = 18;
              double headerMarginTop = 27;
              double wishlistItemsMarginTop = 31;
    
              if (constraints.maxWidth <= 540) {
                horizontalPadding = 0.04 * media.size.width;
                maxContainerWidth = media.size.width;
                wishlistItemImageSize = 92;
                detailsPadding = 10;
                headerMarginTop = 18;
                wishlistItemsMarginTop = 24;
              }
    
              return Center(
                child: SingleChildScrollView(
                  // Contains the whole wishlist container
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      maxWidth: maxContainerWidth,
                    ),
                    padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 36),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: headerMarginTop),
                        _WishlistHeader(
                          onSearch: _onSearchTap,
                        ),
                        SizedBox(height: 24),
                        _WishlistSearchBar(
                          onSearchBarTap: _onSearchTap,
                        ),
                        SizedBox(height: wishlistItemsMarginTop),
                        Text(
                          'Itens na Lista de Desejos',
                          //style: Theme.of(context).textTheme.headline5,
                        ),
                        SizedBox(height: 17),
                        Column(
                          children: List.generate(
                            _wishlistItems.length,
                            (index) => Padding(
                              padding: EdgeInsets.only(
                                  bottom: index == _wishlistItems.length - 1 ? 0 : 17.0),
                              child: WishlistItem(
                                data: _wishlistItems[index],
                                imageSize: wishlistItemImageSize,
                                detailsPadding: detailsPadding,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// Header with title and search icon
class _WishlistHeader extends StatelessWidget {
  final VoidCallback onSearch;

  const _WishlistHeader({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    // For accessibility, use Semantics and InkWell for the search icon.
    return SizedBox(
      height: 26,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Text(
              'Lista de Desejos',
              //style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            right: 0,
            child: Semantics(
              button: true,
              label: 'Search',
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: onSearch,
                child: SizedBox(
                  width: 36,
                  height: 36,
                  child: Center(
                    child: Image.network(
                      'https://app.codigma.io/api/uploads/assets/cd55e117-5700-4ca9-bf38-56d9cad43e01.svg',
                      width: 23,
                      height: 23,
                      fit: BoxFit.contain,
                      semanticLabel: "Search",
                      errorBuilder: (context, error, stack) => Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Search bar (decorative, not functional)
class _WishlistSearchBar extends StatelessWidget {
  final VoidCallback onSearchBarTap;

  const _WishlistSearchBar({required this.onSearchBarTap});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      textField: true,
      label: "Pesquisar",
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF472426),
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onSearchBarTap,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 0, top: 11, bottom: 11),
            child: Row(
              children: [
                Image.network(
                  'https://app.codigma.io/api/uploads/assets/ae99f807-4a51-4749-aa32-7a18c3cd973b.svg',
                  width: 18,
                  height: 18,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stack) => Icon(Icons.search, color: Color(0xFFC99194)),
                  semanticLabel: "Pesquisar",
                ),
                const SizedBox(width: 12),
                Text(
                  'Pesquisar',
                  //style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Wishlist item widget
class WishlistItem extends StatelessWidget {
  final WishlistItemData data;
  final double imageSize;
  final double detailsPadding;

  const WishlistItem({
    super.key,
    required this.data,
    this.imageSize = 104,
    this.detailsPadding = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: '${data.title}, year ${data.year}, brand ${data.brand}',
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2A1819),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: const Color(0x1A180C0E),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: const Color(0xFF3A2324),
              width: imageSize,
              height: imageSize + 1,
              child: Image.network(
                data.imageUrl,
                width: imageSize,
                height: imageSize + 1,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => Icon(
                  Icons.image_not_supported,
                  size: imageSize * 0.67,
                  color: const Color(0xFFC99194),
                ),
                semanticLabel: data.title,
              ),
            ),
            Expanded(
              child: Container(
                color: const Color(0xFF472426),
                padding: EdgeInsets.symmetric(horizontal: detailsPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        Text(
                          data.year,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(width: 12),
                        const Spacer(),
                        Text(
                          data.brand,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}