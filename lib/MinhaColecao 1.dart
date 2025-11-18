// File: MinhaColecao.dart
import 'package:flutter/material.dart';

// --------------------
// Helper Data Classes
// --------------------

class CollectionItemData {
  final String imageUrl;
  final String brand;
  final String model;

  const CollectionItemData({
    required this.imageUrl,
    required this.brand,
    required this.model,
  });
}

class FilterItemData {
  final String label;
  final String? iconUrl;
  final bool hasDropdown;

  const FilterItemData({
    required this.label,
    this.iconUrl,
    this.hasDropdown = false,
  });
}

class FooterNavItemData {
  final String iconUrl;
  final String label;

  const FooterNavItemData({
    required this.iconUrl,
    required this.label,
  });
}

// ---------------------
// Main Widget
// ---------------------

class MinhaColecao extends StatefulWidget {
  const MinhaColecao({Key? key}) : super(key: key);

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
        .where((item) =>
            item.brand.toLowerCase().contains(_searchText.toLowerCase()) ||
            item.model.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();
  }

  // Filter options
  static const List<FilterItemData> _filters = [
    FilterItemData(
      label: 'Marca',
      iconUrl:
          'https://app.codigma.io/api/uploads/assets/c8431eba-4bf7-4f88-98d7-89e82762e82f.svg',
      hasDropdown: true,
    ),
    FilterItemData(
      label: 'Modelo',
      iconUrl:
          'https://app.codigma.io/api/uploads/assets/1dd012f6-208d-46e9-8574-fccd10a60a02.svg',
      hasDropdown: true,
    ),
    FilterItemData(
      label: 'Ano',
      iconUrl:
          'https://app.codigma.io/api/uploads/assets/a110d192-6308-4024-901a-3cdff4b3c1a0.svg',
      hasDropdown: true,
    ),
    FilterItemData(
      label: 'Categoria',
      hasDropdown: false,
    ),
  ];

  // Footer nav options
  static const List<FooterNavItemData> _footerNav = [
    FooterNavItemData(
      iconUrl:
          'https://app.codigma.io/api/uploads/assets/573ab6f5-bf4d-4d98-97ef-5de6c6363f98.svg',
      label: 'Início',
    ),
    FooterNavItemData(
      iconUrl:
          'https://app.codigma.io/api/uploads/assets/dc3173ad-daba-4e8f-8cc9-663b1621627c.svg',
      label: 'Minha Coleção',
    ),
    FooterNavItemData(
      iconUrl:
          'https://app.codigma.io/api/uploads/assets/b499caf2-bc3d-4776-8d4a-8c7af9f22521.svg',
      label: 'Adicionar',
    ),
    FooterNavItemData(
      iconUrl:
          'https://app.codigma.io/api/uploads/assets/00fdd9b0-d830-44db-99d4-9efcb7f420ea.svg',
      label: 'Configurações',
    ),
  ];

  // Colors mapped to the CSS variables
  static const Color _bgMain = Color(0xFF211212);
  static const Color _surface = Color(0xFF472426);
  static const Color _surfaceAlt = Color(0xFF331A1C);
  static const Color _brand = Color(0xFFC99194);
  static const Color _divider = Color(0xFF472426);
  static const Color _white = Colors.white;

  int _footerNavIndex = 1; // For demonstration, "Minha Coleção" is selected

  // Navigation actions for footer (Navigator 1.0)
  void _onFooterNavTapped(int index) {
    if (_footerNavIndex == index) return;
    setState(() {
      _footerNavIndex = index;
    });
    // Demo: navigate based on index
    switch (index) {
      case 0:
        Navigator.of(context).maybePop(); // Go back
        break;
      case 1:
        // Stay in this page
        break;
      case 2:
        // To "Adicionar" screen (dummy push)
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const _DummyAdicionar()));
        break;
      case 3:
        // To settings (dummy push)
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const _DummySettings()));
        break;
    }
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

  @override
  Widget build(BuildContext context) {
    // Use theme data to force light mode colors
    final baseTextTheme = Theme.of(context).textTheme.apply(
          fontFamily: 'Plus Jakarta Sans',
          bodyColor: _white,
          displayColor: _white,
        );

    return Scaffold(
      backgroundColor: _bgMain,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final gridCount = _calculateGridCount(maxWidth);

          return Column(
            children: [
              // HEADER
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.fromLTRB(20, 18, 20, 16), // as per CSS
                decoration: BoxDecoration(
                  color: _bgMain,
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
                        child: Image.network(
                          'https://app.codigma.io/api/uploads/assets/dcac6a09-1650-434a-ae0c-3a7c320972e3.svg',
                          height: 24,
                          width: 24,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
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
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                physics: const BouncingScrollPhysics(),
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
                                          _selectedFilter == i ? -1 : i;
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
                            _CollectionGrid(
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
              _FooterNavBar(
                items: _footerNav,
                surfaceAlt: _surfaceAlt,
                divider: _divider,
                selectedIndex: _footerNavIndex,
                onTap: _onFooterNavTapped,
                brand: _brand,
              ),
            ],
          );
        }),
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
    Key? key,
    required this.backgroundColor,
    required this.iconColor,
    required this.textColor,
    required this.hint,
    required this.onChanged,
  }) : super(key: key);

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
            child: Image.network(
                'https://app.codigma.io/api/uploads/assets/1657f1c2-090d-4b36-b316-a77ffd08ab88.svg',
                color: null, // Keep original filter of svg
                fit: BoxFit.contain),
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
    Key? key,
    required this.data,
    required this.selected,
    required this.onTap,
    required this.color,
    required this.textColor,
    required this.iconColor,
  }) : super(key: key);

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
                  child: Image.network(
                    data.iconUrl!,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// -------------
// CollectionGrid
// -------------

class _CollectionGrid extends StatelessWidget {
  final List<CollectionItemData> items;
  final int gridCount;
  final Color surface;
  final Color brandColor;
  final Color modelColor;

  const _CollectionGrid({
    Key? key,
    required this.items,
    required this.gridCount,
    required this.surface,
    required this.brandColor,
    required this.modelColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Items are non-scrollable grid inside scrollview
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridCount,
        crossAxisSpacing: gridCount == 2
            ? 13
            : gridCount == 3
                ? 13
                : 17,
        mainAxisSpacing: gridCount == 2
            ? 15
            : gridCount == 3
                ? 15
                : 18,
        childAspectRatio: 4 / 4.4, // as per .item: image aspect-ratio 4/3 + details
      ),
      itemBuilder: (ctx, i) => _GridItem(
        item: items[i],
        surface: surface,
        brandColor: brandColor,
        modelColor: modelColor,
      ),
    );
  }
}

class _GridItem extends StatelessWidget {
  final CollectionItemData item;
  final Color surface;
  final Color brandColor;
  final Color modelColor;

  const _GridItem({
    Key? key,
    required this.item,
    required this.surface,
    required this.brandColor,
    required this.modelColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${item.brand}, ${item.model}',
      child: Container(
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  item.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stack) =>
                      Container(color: Colors.grey.shade300),
                  // Avoids unhandled exceptions
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 11),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.brand,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.18,
                      letterSpacing: -0.01,
                      color: brandColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.model,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.12,
                      letterSpacing: -0.01,
                      color: modelColor,
                    ),
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

// -------------
// Footer NavBar
// -------------

class _FooterNavBar extends StatelessWidget {
  final List<FooterNavItemData> items;
  final Color surfaceAlt;
  final Color divider;
  final int selectedIndex;
  final Color brand;
  final void Function(int index) onTap;

  const _FooterNavBar({
    Key? key,
    required this.items,
    required this.surfaceAlt,
    required this.divider,
    required this.selectedIndex,
    required this.brand,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: surfaceAlt,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 600),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: divider, width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.asMap().entries.map((entry) {
            final idx = entry.key;
            final item = entry.value;
            final selected = idx == selectedIndex;
            return Expanded(
              child: GestureDetector(
                onTap: () => onTap(idx),
                child: Semantics(
                  button: true,
                  label: item.label,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 23,
                          width: 23,
                          child: Image.network(
                            item.iconUrl,
                            color: selected ? brand : brand.withAlpha(172),
                          ),
                        ),
                        const SizedBox(height: 0),
                        Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: selected ? brand : brand.withAlpha(172),
                            letterSpacing: -0.01,
                            height: 1.12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// ----------------------
// Dummy Target Screens for Navigation
// ----------------------

class _DummyAdicionar extends StatelessWidget {
  const _DummyAdicionar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Adicionar")),
        body: const Center(child: Text("Adicionar Page")),
      );
}

class _DummySettings extends StatelessWidget {
  const _DummySettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Configurações")),
        body: const Center(child: Text("Configurações Page")),
      );
}