// File: ConfiguracaoAvancada.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Main entry widget for the ConfiguracaoAvancada screen
class ConfiguracaoAvancada extends StatefulWidget {
  const ConfiguracaoAvancada({super.key});

  @override
  State<ConfiguracaoAvancada> createState() => _ConfiguracaoAvancadaState();
}

class _ConfiguracaoAvancadaState extends State<ConfiguracaoAvancada> {
  // For demonstration: change this for navigation logic as needed
  int _selectedNavIndex = 2; // Default: Profile (matches original context)

  // Navigation using Navigator 1.0 - placeholder logic
  void _onNavTap(int index) {
    setState(() {
      _selectedNavIndex = index;
      // Example: Based on index, push new page
      // switch (index) {
      //   case 0: Navigator.pushNamed(context, '/catalog'); break;
      //   ...
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Responsive breakpoints
    final width = MediaQuery.of(context).size.width;
    final maxFeatureDescWidth = width < 390
        ? 140.0
        : width < 400
        ? 170.0
        : width < 480
        ? 226.0
        : 226.0;
    final headerFontSize = width < 375 ? 16.0 : 18.0;
    final featureTitleFontSize = width < 375 ? 14.0 : 16.0;
    final featureDescFontSize = width < 375
        ? 12.0
        : width < 400
        ? 13.2
        : 13.2;

    return Material(
      color: const Color(0xFF121A21),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isSmall = constraints.maxWidth <= 480;
            final isMediumScreen = constraints.maxWidth >= 430;

            // Responsive paddings
            final horizontalContentPadding = isSmall
                ? (width < 400
                      ? 10.0
                      : width < 480
                      ? 16.0
                      : 24.0)
                : 24.0;
            final maxContainerWidth = isMediumScreen ? 430.0 : double.infinity;

            return Stack(
              children: [
                // Main scrollable content, leaving space for the footer
                Column(
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: maxContainerWidth),
                      width: double.infinity,
                      child: _Header(
                        fontSize: headerFontSize,
                        onBackTap: () => context.pop(),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          maxWidth: maxContainerWidth,
                        ),
                        decoration: const BoxDecoration(
                          color: Color(0xFF1A2633),
                          border: Border(
                            top: BorderSide(color: Color(0xFF243647)),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: horizontalContentPadding,
                              right: horizontalContentPadding,
                              top: 0,
                              // bottom: 16, // DO NOT overlap footer
                            ),
                            child: _DataManagementSection(
                              featureTitleFontSize: featureTitleFontSize,
                              featureDescFontSize: featureDescFontSize,
                              maxFeatureDescWidth: maxFeatureDescWidth,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 85.0, // To prevent overlap with footer
                    ),
                  ],
                ),
                // Footer navigation (fixed)
                Positioned(
                  left: isMediumScreen ? width / 2 - 215 : 0,
                  bottom: 0,
                  width: isMediumScreen ? 430 : width,
                  child: FooterNavigation(
                    selectedIndex: _selectedNavIndex,
                    onTap: _onNavTap,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// Header widget
class _Header extends StatelessWidget {
  final double fontSize;
  final VoidCallback onBackTap;

  const _Header({super.key, required this.fontSize, required this.onBackTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: Color(0xFF121A21),
        border: Border(bottom: BorderSide(color: Color(0xFF18202E))),
      ),
      padding: const EdgeInsetsDirectional.only(start: 8),
      child: Row(
        children: [
          Semantics(
            label: "Back",
            button: true,
            child: IconButton(
              onPressed: onBackTap,
              icon: const Image(
                image: NetworkImage(
                  'https://app.codigma.io/api/uploads/assets/4fe6a902-bb6e-44b7-9ffa-33be31e882fa.svg',
                ),
                width: 24,
                height: 24,
              ),
              splashRadius: 24,
              tooltip: "Back",
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "Advanced Settings",
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: fontSize,
                  color: Colors.white,
                  height: 1,
                  letterSpacing: -0.02,
                ),
                semanticsLabel: "Advanced Settings",
              ),
            ),
          ),
          const SizedBox(width: 52), // To match left back icon space
        ],
      ),
    );
  }
}

// Data Management section
class _DataManagementSection extends StatelessWidget {
  final double featureTitleFontSize;
  final double featureDescFontSize;
  final double maxFeatureDescWidth;

  const _DataManagementSection({
    super.key,
    required this.featureTitleFontSize,
    required this.featureDescFontSize,
    required this.maxFeatureDescWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: "Data Management Section",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            "Data Management",
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: -0.01,
            ),
          ),
          const SizedBox(height: 20),
          _FeatureTile(
            iconUrl:
                'https://app.codigma.io/api/uploads/assets/c8b2d29a-f220-4c45-97e3-4d116bf5aa7b.svg',
            title: "Export Data",
            description: "Export data to CSV or JSON",
            titleFontSize: featureTitleFontSize,
            descFontSize: featureDescFontSize,
            maxDescWidth: maxFeatureDescWidth,
          ),
          _FeatureTile(
            iconUrl:
                'https://app.codigma.io/api/uploads/assets/da32190b-854d-4784-813c-54e95ce7c927.svg',
            title: "Setup External Backup",
            description: "Configure external backup to cloud or email services",
            titleFontSize: featureTitleFontSize,
            descFontSize: featureDescFontSize,
            maxDescWidth: maxFeatureDescWidth,
          ),
          _FeatureTile(
            iconUrl:
                'https://app.codigma.io/api/uploads/assets/aeac9ba5-8e72-47a6-bda2-fccdd247e667.svg',
            title: "Setup Local Backup",
            description: "Configure local backup to save on device or SD card",
            titleFontSize: featureTitleFontSize,
            descFontSize: featureDescFontSize,
            maxDescWidth: maxFeatureDescWidth,
            isLast: true,
          ),
        ],
      ),
    );
  }
}

// Advanced feature tile
class _FeatureTile extends StatelessWidget {
  final String iconUrl;
  final String title;
  final String description;
  final double titleFontSize;
  final double descFontSize;
  final double maxDescWidth;
  final bool isLast;

  const _FeatureTile({
    super.key,
    required this.iconUrl,
    required this.title,
    required this.description,
    required this.titleFontSize,
    required this.descFontSize,
    required this.maxDescWidth,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      container: true,
      label: title,
      child: Container(
        margin: EdgeInsets.only(bottom: isLast ? 0 : 14),
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ).copyWith(left: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF243647),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Feature icon
            Container(
              margin: const EdgeInsets.only(right: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image.network(
                  iconUrl,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Description
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxDescWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFCFCFC),
                      height: 1.14,
                      letterSpacing: -0.01,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: descFontSize,
                      color: const Color(0xFF91ADC9),
                      fontWeight: FontWeight.w500,
                      height: 1.38,
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

// Footer Navigation widget
class FooterNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const FooterNavigation({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  static const _navItems = [
    _NavItemData(
      iconUrl:
          'https://app.codigma.io/api/uploads/assets/1ea78e77-b189-42b4-9102-b9441cdc1ac2.svg',
      label: 'Catalog',
    ),
    _NavItemData(
      iconUrl:
          'https://app.codigma.io/api/uploads/assets/aaaadb2d-67d6-4dbd-b1e4-79f661e39dba.svg',
      label: 'Collection',
    ),
    _NavItemData(
      iconUrl:
          'https://app.codigma.io/api/uploads/assets/1daf361e-7c0d-41c1-85f3-5848c72de191.svg',
      label: 'Profile',
    ),
    _NavItemData(
      iconUrl:
          'https://app.codigma.io/api/uploads/assets/9fba2a66-b4da-42ba-a6fb-b6436102e596.svg',
      label: 'Wishlist',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // For shadow and border
    return Material(
      color: const Color(0xFF1A2633),
      elevation: 8,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFF243647), width: 1)),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ).copyWith(left: 20, right: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(_navItems.length, (index) {
            final data = _navItems[index];
            final isSelected = selectedIndex == index;
            return Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => onTap(index),
                child: Semantics(
                  label: data.label,
                  selected: isSelected,
                  button: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(
                          data.iconUrl,
                          width: 27,
                          height: 27,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF91ADC9),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          data.label,
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF91ADC9),
                            letterSpacing: -0.01,
                            height: 1.25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItemData {
  final String iconUrl;
  final String label;

  const _NavItemData({required this.iconUrl, required this.label});
}
