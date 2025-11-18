// File: MinhaColecao.dart
import 'package:flutter/material.dart';

class MinhaColecao extends StatefulWidget {
  const MinhaColecao({Key? key}) : super(key: key);

  @override
  State<MinhaColecao> createState() => _MinhaColecaoState();
}

class _MinhaColecaoState extends State<MinhaColecao> {
  // View modes
  enum ViewMode { grid, list }

  ViewMode _selectedView = ViewMode.grid;

  // For responsive design
  bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 480;
  bool isTablet(BuildContext context) => MediaQuery.of(context).size.width < 700;

  // Dummy navigation for footer (Navigator 1.0 example)
  void _navigateTo(BuildContext context, String route) {
    // Implement navigation logic or just show a SnackBar for demo
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Navigating to: $route")),
    );
    // Navigator.of(context).pushNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    // Colors
    const primaryBg = Color(0xFF211212);
    const secondaryBg = Color(0xFF472426);
    const textMain = Color(0xFFFFFFFF);
    const textSecondary = Color(0xFFC99194);
    const filterBg = secondaryBg;
    const border = secondaryBg;

    return Material(
      color: primaryBg,
      child: Column(
        children: [
          _Header(
            isMobile: isMobile(context),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Responsive paddings
                final double sidePadding = isMobile(context)
                    ? 4
                    : isTablet(context)
                        ? 7
                        : 20;
                final double topPadding = isMobile(context) ? 24 : 28;
                final double bottomPadding = isMobile(context) ? 16 : 22;
                final double maxWidth = isMobile(context) || isTablet(context)
                    ? double.infinity
                    : 520;
                return Container(
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                  color: primaryBg,
                  child: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      padding: EdgeInsets.fromLTRB(
                          sidePadding, topPadding, sidePadding, bottomPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Filters
                          _SavedFilters(isMobile: isMobile(context)),
                          SizedBox(height: 10),
                          _AvailableFilters(isMobile: isMobile(context)),
                          _ViewOptions(
                            selected: _selectedView,
                            onSelect: (mode) =>
                                setState(() => _selectedView = mode),
                            isMobile: isMobile(context),
                          ),
                          _CollectionItems(
                            viewMode: _selectedView,
                            isMobile: isMobile(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          _Footer(
            onNavTap: _navigateTo,
            isMobile: isMobile(context),
            isTablet: isTablet(context),
          ),
        ],
      ),
    );
  }
}

// HEADER
class _Header extends StatelessWidget {
  final bool isMobile;
  const _Header({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    const double headerHeight = 80;
    const bg = Color(0xFF211212);
    const titleColor = Color(0xFFFFFFFF);
    const secondaryBg = Color(0xFF472426);
    const textSecondary = Color(0xFFC99194);

    return Material(
      elevation: 0.5,
      color: bg,
      child: Container(
        height: headerHeight,
        padding: EdgeInsets.only(
            right: isMobile ? 6 : 20, left: 0, top: 0, bottom: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo and Title
            Row(
              children: [
                SizedBox(width: isMobile ? 7 : 20),
                Semantics(
                  label: "App Logo",
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        "https://app.codigma.io/api/uploads/assets/d641e856-c55b-4703-955a-9ae4a7e01aea.svg",
                        height: 48,
                        width: 48,
                        fit: BoxFit.contain,
                      )),
                ),
                SizedBox(width: 16),
                Text(
                  "My Collection",
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.01,
                    fontFamily: 'Plus Jakarta Sans',
                  ),
                ),
              ],
            ),
            // Search Bar
            Semantics(
              label: "Search bar",
              child: Container(
                decoration: BoxDecoration(
                  color: secondaryBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: isMobile ? 8 : 11,
                  horizontal: isMobile ? 10 : 20,
                ),
                height: 48,
                constraints: BoxConstraints(minWidth: isMobile ? 0 : 150),
                child: Row(
                  children: [
                    Image.network(
                      "https://app.codigma.io/api/uploads/assets/c496fc99-dcc4-4cbb-8b72-4a9da7f8826f.svg",
                      width: 22,
                      height: 22,
                      color: textSecondary.withOpacity(0.9),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Search",
                      style: TextStyle(
                        color: textSecondary,
                        fontSize: isMobile ? 15 : 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Plus Jakarta Sans',
                      ),
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

// SAVED FILTERS
class _SavedFilters extends StatelessWidget {
  final bool isMobile;
  const _SavedFilters({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    const textSecondary = Color(0xFFC99194);
    const filterBg = Color(0xFF472426);
    final double fontSize = isMobile ? 14 : 15;
    final double vPadding = isMobile ? 9 : 6;
    final double hPadding = isMobile ? 9 : 18;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          header: true,
          child: Text(
            "Saved Filters",
            style: TextStyle(
              color: textSecondary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: 'Plus Jakarta Sans',
            ),
          ),
        ),
        SizedBox(height: 4),
        ...[
          "Brand: Hot Wheels, Maisto",
          "Year: 2020-2023"
        ].map(
          (label) => Container(
            margin: EdgeInsets.only(bottom: 9),
            decoration: BoxDecoration(
              color: filterBg,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(
                vertical: vPadding, horizontal: hPadding),
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Plus Jakarta Sans',
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// AVAILABLE FILTERS
class _AvailableFilters extends StatelessWidget {
  final bool isMobile;
  const _AvailableFilters({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    const textSecondary = Color(0xFFC99194);
    const filterBg = Color(0xFF472426);

    final filters = [
      {
        "label": "Brand",
        "icon":
            "https://app.codigma.io/api/uploads/assets/7d5b62d9-4f44-412f-a0b6-06681e0002a6.svg"
      },
      {
        "label": "Model",
        "icon":
            "https://app.codigma.io/api/uploads/assets/ca7d9830-65a9-4e65-b26d-9cf7671e56d2.svg"
      },
      {
        "label": "Year",
        "icon":
            "https://app.codigma.io/api/uploads/assets/c89b4eef-555c-4f6b-8421-f0f43f212c46.svg"
      },
      {
        "label": "Scale",
        "icon":
            "https://app.codigma.io/api/uploads/assets/7d5b62d9-4f44-412f-a0b6-06681e0002a6.svg"
      },
      {
        "label": "Condition",
        "icon":
            "https://app.codigma.io/api/uploads/assets/7d5b62d9-4f44-412f-a0b6-06681e0002a6.svg"
      },
    ];

    final double fontSize = isMobile ? 14 : 15;
    final double vPadding = isMobile ? 9 : 11;
    final double hPadding = isMobile ? 9 : 18;

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
        SizedBox(height: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: filters
              .map(
                (e) => _FilterOption(
                  label: e["label"]!,
                  iconUrl: e["icon"]!,
                  fontSize: fontSize,
                  vPadding: vPadding,
                  hPadding: hPadding,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _FilterOption extends StatelessWidget {
  final String label;
  final String iconUrl;
  final double fontSize;
  final double vPadding;
  final double hPadding;

  const _FilterOption({
    required this.label,
    required this.iconUrl,
    required this.fontSize,
    required this.vPadding,
    required this.hPadding,
  });

  @override
  Widget build(BuildContext context) {
    const filterBg = Color(0xFF472426);

    return Semantics(
      button: true,
      label: "$label filter",
      child: InkWell(
        onTap: () {
          // TODO: Open filter popup
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Open $label filter (Not implemented)")));
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          margin: EdgeInsets.only(bottom: 11),
          decoration: BoxDecoration(
            color: filterBg,
            borderRadius: BorderRadius.circular(8),
          ),
          padding:
              EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                ),
              )),
              Image.network(
                iconUrl,
                width: 24,
                height: 24,
                color: Colors.white.withOpacity(0.9),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// VIEW OPTIONS ("Grid" vs "List" Toggle)
enum ViewMode { grid, list }

class _ViewOptions extends StatelessWidget {
  final ViewMode selected;
  final ValueChanged<ViewMode> onSelect;
  final bool isMobile;
  const _ViewOptions(
      {required this.selected, required this.onSelect, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    const primaryBg = Color(0xFF211212);
    const textSecondary = Color(0xFFC99194);

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Grid
          _ViewOptionButton(
            text: "Grid",
            isSelected: selected == ViewMode.grid,
            onTap: () => onSelect(ViewMode.grid),
            isMobile: isMobile,
          ),
          SizedBox(width: 14),
          // List
          _ViewOptionButton(
            text: "List",
            isSelected: selected == ViewMode.list,
            onTap: () => onSelect(ViewMode.list),
            isMobile: isMobile,
          ),
        ],
      ),
    );
  }
}

class _ViewOptionButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isMobile;

  const _ViewOptionButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    const primaryBg = Color(0xFF211212);
    const textSecondary = Color(0xFFC99194);

    return SizedBox(
      height: 40,
      child: Semantics(
        button: true,
        label: "View as $text",
        selected: isSelected,
        child: ElevatedButton(
          style: ButtonStyle(
            minimumSize:
                MaterialStateProperty.all(Size(isMobile ? 70 : 120, 40)),
            backgroundColor: MaterialStateProperty.all(
              isSelected ? textSecondary : primaryBg,
            ),
            foregroundColor: MaterialStateProperty.all(
              isSelected ? primaryBg : textSecondary,
            ),
            elevation: MaterialStateProperty.all(1),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )),
            overlayColor:
                MaterialStateProperty.all(Colors.white.withOpacity(0.04)),
          ),
          onPressed: onTap,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              fontFamily: 'Plus Jakarta Sans',
            ),
          ),
        ),
      ),
    );
  }
}

// COLLECTION ITEMS, Grid or List mode toggled by [viewMode]
class _CollectionItems extends StatelessWidget {
  final ViewMode viewMode;
  final bool isMobile;
  const _CollectionItems({
    required this.viewMode,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    // Item data
    final items = const [
      {
        "img":
            "https://app.codigma.io/api/uploads/assets/1f6ea58b-e237-4ddf-bdcf-546baa99271c.png",
        "brand": "Hot Wheels",
        "model": "Ford Mustang"
      },
      {
        "img":
            "https://app.codigma.io/api/uploads/assets/7108395f-b606-4a25-9130-e50d55e64f38.png",
        "brand": "Maisto",
        "model": "Chevrolet Camaro"
      },
      {
        "img":
            "https://app.codigma.io/api/uploads/assets/bc34548f-7a50-4a00-b5f3-c3c841002e5e.png",
        "brand": "Matchbox",
        "model": "Volkswagen Beetle"
      },
      {
        "img":
            "https://app.codigma.io/api/uploads/assets/de634606-0b28-4a91-b36d-e540a850ca58.png",
        "brand": "Greenlight",
        "model": "Dodge Charger"
      },
      {
        "img":
            "https://app.codigma.io/api/uploads/assets/e1f750b9-1103-4f57-a3fb-1d6fc4871f3d.png",
        "brand": "Jada Toys",
        "model": "Nissan GT-R"
      },
      {
        "img":
            "https://app.codigma.io/api/uploads/assets/90dc5823-bf28-4e38-b49c-d42063d131b3.png",
        "brand": "Auto World",
        "model": "Porsche 911"
      },
    ];

    // Responsive grid count
    int columns = isMobile ? 2 : 2; // Could be adapted for >700px for 3
    double itemAspectRatio = 1.5;

    Widget grid = GridView.builder(
      padding: EdgeInsets.only(top: 16),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: isMobile ? 8 : 17,
        mainAxisSpacing: isMobile ? 8 : 17,
        childAspectRatio: itemAspectRatio,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final it = items[index];
        return _CollectionItemCard(
          imgUrl: it['img']!,
          brand: it['brand']!,
          model: it['model']!,
          isMobile: isMobile,
        );
      },
    );

    Widget list = ListView.separated(
      padding: const EdgeInsets.only(top: 16),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, __) => SizedBox(height: isMobile ? 8 : 17),
      itemBuilder: (context, index) {
        final it = items[index];
        return _CollectionItemRow(
          imgUrl: it['img']!,
          brand: it['brand']!,
          model: it['model']!,
          isMobile: isMobile,
        );
      },
    );

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 170),
      child: viewMode == ViewMode.grid ? grid : list,
    );
  }
}

// CARD for grid view
class _CollectionItemCard extends StatelessWidget {
  final String imgUrl;
  final String brand;
  final String model;
  final bool isMobile;
  const _CollectionItemCard({
    required this.imgUrl,
    required this.brand,
    required this.model,
    required this.isMobile,
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
            // TODO: Show item details page/sheet
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("$brand $model tapped!")));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: Image.network(
                    imgUrl,
                    fit: BoxFit.cover,
                  ),
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

// ROW for list view
class _CollectionItemRow extends StatelessWidget {
  final String imgUrl;
  final String brand;
  final String model;
  final bool isMobile;
  const _CollectionItemRow({
    required this.imgUrl,
    required this.brand,
    required this.model,
    required this.isMobile,
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
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("$brand $model tapped!")));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: isMobile ? 8 : 12, horizontal: isMobile ? 8 : 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imgUrl,
                    width: isMobile ? 70 : 90,
                    height: isMobile ? 46 : 60,
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
                          fontSize: isMobile ? 15 : 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.01,
                        ),
                      ),
                      Text(
                        model,
                        style: TextStyle(
                          color: textSecondary,
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: isMobile ? 13 : 14,
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

// FOOTER NAVIGATION
class _Footer extends StatelessWidget {
  final Function(BuildContext, String) onNavTap;
  final bool isMobile;
  final bool isTablet;
  const _Footer({
    required this.onNavTap,
    required this.isMobile,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    const primaryBg = Color(0xFF211212);
    const border = Color(0xFF472426);
    const textSecondary = Color(0xFFC99194);

    final navs = [
      {
        'icon':
            "https://app.codigma.io/api/uploads/assets/0eb1f186-a1a4-4cd5-ba93-f039dbb6b66f.svg",
        'label': "Home",
        'route': "/home"
      },
      {
        'icon':
            "https://app.codigma.io/api/uploads/assets/bad9b50c-19b8-4db8-80bd-829e7767378b.svg",
        'label': "My Collection",
        'route': "/collection"
      },
      {
        'icon':
            "https://app.codigma.io/api/uploads/assets/b15ac91b-1c37-4877-8511-92e61cd3a038.svg",
        'label': "Add",
        'route': "/add"
      },
      {
        'icon':
            "https://app.codigma.io/api/uploads/assets/c004391b-6f55-4d33-be75-d0c7e752e0dd.svg",
        'label': "Settings",
        'route': "/settings"
      },
    ];
    // Responsive
    final double imgSize = isMobile ? 27 : 33;
    final double fontSize = isMobile ? 11 : 13;
    final double verticalPadding = isMobile ? 4 : 8;

    return Container(
      color: primaryBg,
      padding: EdgeInsets.only(bottom: 0, top: verticalPadding, left: 0, right: 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
          color: border,
          width: 1.4,
        ))),
        child: Center(
          child: Container(
            constraints: BoxConstraints(
                maxWidth: isMobile || isTablet ? double.infinity : 520),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: navs.map((n) {
                return Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(6),
                    onTap: () => onNavTap(context, n['route']!),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: isMobile ? 4 : 7),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.network(
                            n['icon']!,
                            width: imgSize,
                            height: imgSize,
                            fit: BoxFit.contain,
                            color: null,
                          ),
                          SizedBox(height: 1),
                          Text(
                            n['label']!,
                            style: TextStyle(
                              color: textSecondary,
                              fontSize: fontSize,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Plus Jakarta Sans',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}