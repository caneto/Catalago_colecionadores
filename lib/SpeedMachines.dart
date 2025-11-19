// File: SpeedMachines.dart
import 'package:flutter/material.dart';

// -- Car Data Model --
class Car {
  final String name;
  final String year;
  final String imageUrl;

  Car({
    required this.name,
    required this.year,
    required this.imageUrl,
  });
}

// -- Main Widget --
class SpeedMachines extends StatefulWidget {
  const SpeedMachines({super.key});

  @override
  State<SpeedMachines> createState() => _SpeedMachinesState();
}

class _SpeedMachinesState extends State<SpeedMachines> {
  // Static car list (could be made dynamic/fetched in future)
  final List<Car> cars = [
    Car(
      name: 'Ferrari LaFerrari',
      year: '2013',
      imageUrl: 'https://app.codigma.io/api/uploads/assets/d32de4a4-b3b4-47b2-b408-37d45cfae5db.png',
    ),
    Car(
      name: 'Bugatti Chiron',
      year: '2016',
      imageUrl: 'https://app.codigma.io/api/uploads/assets/507a766b-a2dc-4143-a530-8591c39b5745.png',
    ),
    Car(
      name: 'McLaren P1',
      year: '2013',
      imageUrl: 'https://app.codigma.io/api/uploads/assets/6f6b3d1e-e71e-4e05-a83e-b4783a3a9310.png',
    ),
    Car(
      name: 'Porsche 918 Spyder',
      year: '2013',
      imageUrl: 'https://app.codigma.io/api/uploads/assets/a6eae1d7-bbab-4cff-8027-2ed21f310edb.png',
    ),
    Car(
      name: 'Lamborghini Aventador',
      year: '2011',
      imageUrl: 'https://app.codigma.io/api/uploads/assets/16a10a90-6b31-4c2b-9110-dedcf92c3419.png',
    ),
    Car(
      name: 'Koenigsegg Agera R',
      year: '2011',
      imageUrl: 'https://app.codigma.io/api/uploads/assets/41bd4aef-1baa-49de-8785-424b8dc60520.png',
    ),
    Car(
      name: 'Pagani Huayra',
      year: '2012',
      imageUrl: 'https://app.codigma.io/api/uploads/assets/1048d18d-296e-4e2a-8612-63f8afe20cee.png',
    ),
    Car(
      name: 'Aston Martin One-77',
      year: '2011',
      imageUrl: 'https://app.codigma.io/api/uploads/assets/e49c27e1-4d90-4b21-bbd4-cba1d08b97b6.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Use light theme colors as base
    final theme = Theme.of(context);

    // Responsive paddings and card sizing
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF121A21),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isMobile = constraints.maxWidth < 580;
            final bool isSmallMobile = constraints.maxWidth < 420;
            // Gallery responsiveness
            final double cardWidth = isMobile
                ? (screenWidth * 0.96).clamp(0, 290)
                : 173;

            final double galleryGap = isMobile ? 13 : 16;
            final double horizontalPadding = isMobile ? 9 : 16;
            final double headerLeftPadding = isSmallMobile ? 13 : 24;
            final double headerTopPadding = isSmallMobile ? 19 : 24;
            final double headerBottomPadding = isSmallMobile ? 13 : 18;
            final double introFontSize = isSmallMobile ? 15.5 : 17.0;
            final double introSidePadding = isSmallMobile ? 12 : 24;
            final double searchVerticalPadding = isSmallMobile ? 10 : 13;
            final double searchHorizontalPaddingLeft = isSmallMobile ? 12 : 18;
            final double searchHorizontalPaddingRight = isSmallMobile ? 11 : 16;
            final double searchMargin = isSmallMobile ? 9 : 24;

            return Container(
              color: const Color(0xFF121A21),
              child: Column(
                children: [
                  // -- Header --
                  _Header(
                    leftPadding: headerLeftPadding,
                    topPadding: headerTopPadding,
                    bottomPadding: headerBottomPadding,
                  ),

                  // -- Introductory Section --
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        introSidePadding, 0, introSidePadding, 18),
                    child: Text(
                      "A collection of the fastest and most powerful cars ever produced, featuring iconic models from top manufacturers.",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: introFontSize,
                        height: 1.45,
                        color: const Color(0xFFB9D1E9),
                        fontFamily: 'Plus Jakarta Sans',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // -- Search Box Section (non-interactive, per design) --
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        searchMargin, 0, searchMargin, 18),
                    child: _SearchBar(
                      vPadding: searchVerticalPadding,
                      hPaddingLeft: searchHorizontalPaddingLeft,
                      hPaddingRight: searchHorizontalPaddingRight,
                    ),
                  ),

                  // -- Gallery Section --
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                            horizontalPadding, 8, horizontalPadding, 24),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: galleryGap,
                          runSpacing: galleryGap,
                          children: cars
                              .map((car) => _CarCard(
                                    car: car,
                                    width: cardWidth.toDouble(),
                                    key: ValueKey(car.imageUrl +
                                        car.name +
                                        car.year),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  // -- Footer (dummy for height) --
                  Container(
                    height: 29,
                    color: const Color(0xFF121A21),
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

// -- Header Widget --
class _Header extends StatelessWidget {
  final double leftPadding;
  final double topPadding;
  final double bottomPadding;
  const _Header({
    super.key,
    required this.leftPadding,
    required this.topPadding,
    required this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: topPadding, bottom: bottomPadding, left: 0, right: 0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Logo (absolutely positioned)
          Positioned(
            left: leftPadding,
            top: 0,
            bottom: 0,
            child: Semantics(
              label: "Speed Machines Logo",
              child: Image.network(
                "https://app.codigma.io/api/uploads/assets/6ef22dbc-d361-4f3e-a2e6-fc83c42d50c5.svg",
                width: 48,
                height: 48,
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Title
          Center(
            child: Text(
              "Speed Machines",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.02,
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 32,
                  ),
              textAlign: TextAlign.center,
              semanticsLabel: "Speed Machines App Title",
            ),
          ),
        ],
      ),
    );
  }
}

// -- Search Bar Widget (non-editable, per spec) --
class _SearchBar extends StatelessWidget {
  final double vPadding;
  final double hPaddingLeft;
  final double hPaddingRight;
  const _SearchBar({
    super.key,
    required this.vPadding,
    required this.hPaddingLeft,
    required this.hPaddingRight,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "Search within Speed Machines",
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF243647),
          borderRadius: BorderRadius.circular(11),
        ),
        padding: EdgeInsets.fromLTRB(
            hPaddingLeft, vPadding, hPaddingRight, vPadding),
        child: Row(
          children: [
            Image.network(
              "https://app.codigma.io/api/uploads/assets/e037a342-098d-4d4e-831c-e6d6765fc955.svg",
              width: 26,
              height: 26,
              color: null,
              filterQuality: FilterQuality.high,
              fit: BoxFit.contain,
              semanticLabel: "Search Icon",
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Text(
                "Search within Speed Machines",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF91ADC9),
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      letterSpacing: 0.01,
                      fontFamily: 'Plus Jakarta Sans',
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -- Car Card Widget --
class _CarCard extends StatelessWidget {
  final Car car;
  final double width;

  const _CarCard({
    super.key,
    required this.car,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "${car.name}, ${car.year}",
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: const Color(0xFF243647),
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.13),
              blurRadius: 14,
              offset: const Offset(0, 2),
              spreadRadius: -1,
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            // Could implement navigation on tap
            borderRadius: BorderRadius.circular(13),
            splashFactory: InkRipple.splashFactory,
            onTap: null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Car Image
                Container(
                  height: 98,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xFF1A2430),
                      border: const Border(
                        bottom: BorderSide(
                          color: Color.fromRGBO(255, 255, 255, 0.13),
                          width: 2.5,
                        ),
                      )),
                  child: Image.network(
                    car.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 98,
                    alignment: Alignment.topCenter,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                          child: SizedBox(
                              width: 28,
                              height: 28,
                              child: CircularProgressIndicator(
                                valueColor:
                                    const AlwaysStoppedAnimation(Colors.white24),
                              )));
                    },
                    semanticLabel: car.name,
                  ),
                ),
                // Car Details
                Padding(
                  padding: const EdgeInsets.fromLTRB(13, 13, 12, 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        car.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontSize: 17.8,
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  height: 1.28,
                                ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        car.year,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 15.5,
                              color: const Color(0xFF91ADC9),
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.01,
                              fontFamily: 'Plus Jakarta Sans',
                              height: 1.2,
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