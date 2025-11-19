// File: MiniatureDetails.dart

import 'package:flutter/material.dart';

// Main entry point for the Miniature Details page
class MiniatureDetails extends StatefulWidget {
  const MiniatureDetails({super.key});

  @override
  State<MiniatureDetails> createState() => _MiniatureDetailsState();
}

class _MiniatureDetailsState extends State<MiniatureDetails> {
  // Initial Gallery Index
  int selectedGalleryIndex = 0;

  // For like/dislike simulation per review
  List<ReviewInteraction> reviewInteractions = [
    ReviewInteraction(
      likes: 15,
      dislikes: 2,
      userLiked: false,
      userDisliked: false,
    ),
    ReviewInteraction(
      likes: 8,
      dislikes: 1,
      userLiked: false,
      userDisliked: false,
    ),
  ];

  // Footer navigation (simulate selection, if desired)
  int footerIndex = 0;

  // Gallery image list
  final List<String> galleryImages = [
    "https://app.codigma.io/api/uploads/assets/bd7e40e4-e070-4638-bd63-bd463ddf176e.png",
    "https://app.codigma.io/api/uploads/assets/c4368da1-e685-46e0-8880-d8f8d90857da.png",
    "https://app.codigma.io/api/uploads/assets/d5554b9b-c9b6-4ee6-bd7f-f808df6ed78a.png",
  ];

  final String mainImage =
      "https://app.codigma.io/api/uploads/assets/bd7e40e4-e070-4638-bd63-bd463ddf176e.png";

  // Reviews Data (English only, as per instruction; originals are in PT)
  final List<_UserReviewData> userReviews = [
    _UserReviewData(
      avatar:
          "https://app.codigma.io/api/uploads/assets/bc1f4b66-2192-404a-a0e3-65f7e4e5124b.svg",
      author: "Lucas Silva",
      date: "2 weeks ago",
      stars: [
        "https://app.codigma.io/api/uploads/assets/29292c3e-ac30-4734-a107-ef1f77d80aec.svg",
        "https://app.codigma.io/api/uploads/assets/5256f4da-d591-41b0-af9d-1dff9202a822.svg",
        "https://app.codigma.io/api/uploads/assets/fb432f1e-ca93-434a-9dac-217aef1aba08.svg",
        "https://app.codigma.io/api/uploads/assets/e6d05e1c-f3a9-4d51-b084-ab183a11d75c.svg",
        "https://app.codigma.io/api/uploads/assets/fe371707-c9ff-4cb8-9bed-48be74bbea32.svg",
      ],
      text:
          "This miniature is amazing! The quality of the details is impressive and the painting is perfect. An essential item for any collector.",
    ),
    _UserReviewData(
      avatar:
          "https://app.codigma.io/api/uploads/assets/0bfbede0-f1d8-44d0-a41d-63ce5e85cee3.svg",
      author: "Mariana Costa",
      date: "1 month ago",
      stars: [
        "https://app.codigma.io/api/uploads/assets/9447e7e0-3220-4025-96c6-83d44a1443b9.svg",
        "https://app.codigma.io/api/uploads/assets/f26a4152-3ee8-4d7b-81a2-babe57480e65.svg",
        "https://app.codigma.io/api/uploads/assets/28b01eb9-87c1-4884-8bf3-aa469264ca2e.svg",
        "https://app.codigma.io/api/uploads/assets/dacdf8cb-9edb-4fec-8f06-79653d41676f.svg",
        "https://app.codigma.io/api/uploads/assets/49f94877-d0ca-4424-bd11-9da801545a84.svg",
      ],
      text:
          "The miniature is very good, but the packaging came a bit damaged. Overall, I'm satisfied with the purchase.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Responsive constraints
    final media = MediaQuery.of(context);
    final isSmall = media.size.width <= 430;
    final isMedium = media.size.width <= 630;

    // Colors (matching the CSS scheme)
    const backgroundColor = Color(0xFF121721); // #121721
    const secondaryBg = Color(0xFF161C2C);
    const borderColor = Color(0xFF232B3E);
    const galleryBorder = Color(0xFF28396B);
    const blueMain = Color(0xFF0D40A6);
    const blueHighlight = Color(0xFF0172CB);
    const starFillColor = blueMain;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: backgroundColor,
        fontFamily: 'Plus Jakarta Sans',
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: backgroundColor,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          headlineSmall: TextStyle(
            color: Colors.white,
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
          titleMedium: TextStyle(
            color: Color(0xFFBAC8EB),
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
          bodyMedium: TextStyle(
            color: Color(0xFFBAC8EB),
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
        ),
      ),
      home: Scaffold(
        backgroundColor: backgroundColor,
        extendBody: true,
        body: SafeArea(
          child: Container(
            color: backgroundColor,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    _MiniatureHeader(isMedium: isMedium),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          _MiniatureGallery(
                            images: galleryImages,
                            selectedIndex: selectedGalleryIndex,
                            onTap: (i) =>
                                setState(() => selectedGalleryIndex = i),
                            isSmall: isSmall,
                            isMedium: isMedium,
                          ),
                          _MiniatureInfoSection(isMedium: isMedium),
                          _MiniatureReviewsSection(),
                          _UserReviewsSection(
                            reviews: userReviews,
                            interactions: reviewInteractions,
                            onLike: (i) {
                              setState(() {
                                // Simple toggle logic; update counts accordingly
                                if (!reviewInteractions[i].userLiked) {
                                  reviewInteractions[i].likes++;
                                  if (reviewInteractions[i].userDisliked) {
                                    reviewInteractions[i].dislikes--;
                                    reviewInteractions[i].userDisliked = false;
                                  }
                                  reviewInteractions[i].userLiked = true;
                                } else {
                                  reviewInteractions[i].likes--;
                                  reviewInteractions[i].userLiked = false;
                                }
                              });
                            },
                            onDislike: (i) {
                              setState(() {
                                if (!reviewInteractions[i].userDisliked) {
                                  reviewInteractions[i].dislikes++;
                                  if (reviewInteractions[i].userLiked) {
                                    reviewInteractions[i].likes--;
                                    reviewInteractions[i].userLiked = false;
                                  }
                                  reviewInteractions[i].userDisliked = true;
                                } else {
                                  reviewInteractions[i].dislikes--;
                                  reviewInteractions[i].userDisliked = false;
                                }
                              });
                            },
                          ),
                          SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: _MiniatureFooterNavBar(
          onRemove: () {},
          index: footerIndex,
          onItemSelected: (i) {
            setState(() => footerIndex = i);
            // Simple navigation using Navigator 1.0 (push replacement with dummy routes)
            switch (i) {
              case 0:
                // Simulate navigation
                break;
              case 1:
              case 2:
              case 3:
                // Add navigation logic as needed
                break;
            }
          },
        ),
      ),
    );
  }
}

// Header Widget
class _MiniatureHeader extends StatelessWidget {
  final bool isMedium;
  const _MiniatureHeader({required this.isMedium});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: isMedium ? 12.0 : 24.0),
        height: 64,
        decoration: const BoxDecoration(
          color: Color(0xFF121721),
          border: Border(bottom: BorderSide(color: Color(0xFF232B3E))),
        ),
        child: Row(
          children: [
            // Logo
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              child: Image.network(
                "https://app.codigma.io/api/uploads/assets/4eefb8f2-e4e9-471e-9bf4-1d8ff5c4b1f1.svg",
                width: 40,
                height: 40,
                fit: BoxFit.contain,
                semanticLabel: "Logo",
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  "Miniature Details",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.02,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            // Action Icon
            Container(
              width: 40,
              alignment: Alignment.centerRight,
              child: Image.network(
                "https://app.codigma.io/api/uploads/assets/bd675cd4-d416-42e2-a0f5-8edb85e8425f.svg",
                width: 24,
                height: 24,
                fit: BoxFit.contain,
                semanticLabel: "Action Icon",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Image gallery with selectable image
class _MiniatureGallery extends StatelessWidget {
  final List<String> images;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final bool isSmall;
  final bool isMedium;

  const _MiniatureGallery({
    super.key,
    required this.images,
    required this.selectedIndex,
    required this.onTap,
    required this.isSmall,
    required this.isMedium,
  });

  @override
  Widget build(BuildContext context) {
    final imgWidth = isSmall ? 75.0 : 86.0;
    final imgHeight = isSmall ? 58.0 : 64.0;
    final horizontalPadding = isMedium ? 13.0 : 24.0;
    final gap = isSmall ? 8.0 : 14.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        24,
        horizontalPadding,
        12,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF161C2C),
        border: Border(bottom: BorderSide(color: Color(0xFF252D44))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(images.length, (i) {
          final isSelected = selectedIndex == i;
          return Padding(
            padding: EdgeInsets.only(right: i != images.length - 1 ? gap : 0),
            child: GestureDetector(
              onTap: () => onTap(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                curve: Curves.easeIn,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.09),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  border: Border.all(
                    color: isSelected ? Color(0xFF0D40A6) : Color(0xFF28396B),
                    width: 1.5,
                  ),
                ),
                child: Image.network(
                  images[i],
                  width: imgWidth,
                  height: imgHeight,
                  fit: BoxFit.cover,
                  color: isSelected ? null : null,
                  semanticLabel: "Miniature Image ${i + 1}",
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// Info section under the gallery
class _MiniatureInfoSection extends StatelessWidget {
  final bool isMedium;

  const _MiniatureInfoSection({super.key, required this.isMedium});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = isMedium ? 13.0 : 24.0;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        20,
        horizontalPadding,
        18,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF121721),
        border: Border(bottom: BorderSide(color: Color(0xFF252D44))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ford Mustang",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          Semantics(
            label: "Brand: Hot Wheels",
            child: Text(
              "Brand: Hot Wheels",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Text(
            "Model: Ford Mustang",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text("Year: 1967", style: Theme.of(context).textTheme.bodyMedium),
          Text("Scale: 1:64", style: Theme.of(context).textTheme.bodyMedium),
          Text(
            "Condition: Excellent",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            "Notes: Limited edition, original paint",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

// Reviews Section
class _MiniatureReviewsSection extends StatelessWidget {
  const _MiniatureReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = MediaQuery.of(context).size.width <= 630
        ? 13.0
        : 24.0;

    // Dummy star images (mimic .svg in PNG if needed for real app)
    final stars = [
      "https://app.codigma.io/api/uploads/assets/2eb894a8-9295-4cb0-83de-c65d33a87278.svg",
      "https://app.codigma.io/api/uploads/assets/e3f0af07-3e49-431e-90c6-bce083d9c593.svg",
      "https://app.codigma.io/api/uploads/assets/b45a405f-d980-4611-b935-6323ca6aa9fe.svg",
      "https://app.codigma.io/api/uploads/assets/45f02d59-aaf7-4e8d-9d45-2831af5f6b91.svg",
      "https://app.codigma.io/api/uploads/assets/a0860ddd-d430-40f1-9d7e-4dd5ae2ed38e.svg",
    ];

    final detailedRatings = [
      _DetailedRating(rating: 5, percent: 40),
      _DetailedRating(rating: 4, percent: 30),
      _DetailedRating(rating: 3, percent: 15),
      _DetailedRating(rating: 2, percent: 10),
      _DetailedRating(rating: 1, percent: 5),
    ];

    return Container(
      padding: EdgeInsets.fromLTRB(horizontalPadding, 22, horizontalPadding, 0),
      decoration: const BoxDecoration(color: Color(0xFF121721)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Reviews and Comments",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Text(
                "4.5",
                style: TextStyle(
                  color: Color(0xFF0D40A6),
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -2,
                  height: 1.05,
                ),
                semanticsLabel: "Average Rating 4.5",
              ),
              const SizedBox(width: 13),
              Row(
                children: stars
                    .map(
                      (star) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.5),
                        child: Image.network(
                          star,
                          width: 18,
                          height: 18,
                          semanticLabel: "Star",
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(width: 14),
              Text(
                "123 reviews",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Color(0xFF91A3C9),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            children: detailedRatings
                .map(
                  (r) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _RatingBar(rating: r.rating, percent: r.percent),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

// One detailed rating bar for the ratings histogram
class _RatingBar extends StatelessWidget {
  final int rating;
  final int percent; // percent (ex: 40 means 40%)
  const _RatingBar({required this.rating, required this.percent});

  @override
  Widget build(BuildContext context) {
    final Color fillColor1 = const Color(0xFF0172CB);
    final Color fillColor2 = const Color(0xFF0D40A6);
    final double maxBarWidth = 210.0;
    final double minBarWidth = 50.0;

    return Row(
      children: [
        SizedBox(
          width: 18,
          child: Text(
            rating.toString(),
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Container(
            height: 7,
            constraints: BoxConstraints(
              minWidth: minBarWidth,
              maxWidth: maxBarWidth,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF233459),
              borderRadius: BorderRadius.circular(3.5),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: percent / 100 * maxBarWidth,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [fillColor1, fillColor2],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(3.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: 40,
          child: Text(
            "$percent%",
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF91A3C9),
              fontSize: 13,
              fontWeight: FontWeight.w400,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
        ),
      ],
    );
  }
}

// User Reviews Section (list of reviews)
class _UserReviewsSection extends StatelessWidget {
  final List<_UserReviewData> reviews;
  final List<ReviewInteraction> interactions;
  final ValueChanged<int> onLike;
  final ValueChanged<int> onDislike;
  const _UserReviewsSection({
    required this.reviews,
    required this.interactions,
    required this.onLike,
    required this.onDislike,
  });

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = MediaQuery.of(context).size.width <= 630
        ? 13.0
        : 24.0;

    return Container(
      padding: EdgeInsets.fromLTRB(horizontalPadding, 24, horizontalPadding, 8),
      color: const Color(0xFF121721),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(reviews.length, (i) {
          final r = reviews[i];
          final review = interactions[i];
          return Padding(
            padding: EdgeInsets.only(bottom: i < reviews.length - 1 ? 30 : 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                Semantics(
                  label: "User Avatar",
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF232B3E),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        width: 1.25,
                        color: const Color(0xFF232B3E),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.network(
                        r.avatar,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        r.author,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 15.5,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        r.date,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF8DA0D6),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.02,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: r.stars
                            .map(
                              (star) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 1.0,
                                ),
                                child: Image.network(
                                  star,
                                  width: 16,
                                  height: 16,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        r.text,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 15,
                          color: const Color(0xFFBAC8EB),
                          fontWeight: FontWeight.w400,
                          height: 1.6,
                        ),
                      ),
                      // Interactions
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => onLike(i),
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Row(
                                children: [
                                  Image.network(
                                    [
                                      "https://app.codigma.io/api/uploads/assets/6a073602-dd74-41b0-8ec7-fa066a89c6c3.svg",
                                      "https://app.codigma.io/api/uploads/assets/68ff7f60-6cb1-4080-b30c-eed110304f7f.svg",
                                    ][i],
                                    width: 16,
                                    height: 16,
                                    color: review.userLiked
                                        ? Theme.of(context).colorScheme.primary
                                        : const Color(0xFF7BA9EC),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    review.likes.toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: review.userLiked
                                          ? Color(0xFF0D40A6)
                                          : Color(0xFF7BA9EC),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 32),
                          GestureDetector(
                            onTap: () => onDislike(i),
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Row(
                                children: [
                                  Image.network(
                                    [
                                      "https://app.codigma.io/api/uploads/assets/6426c641-dcc1-4c8d-8c58-39f345f63289.svg",
                                      "https://app.codigma.io/api/uploads/assets/8e99de19-b513-4dc8-8e6e-63af4e11d6f4.svg",
                                    ][i],
                                    width: 16,
                                    height: 16,
                                    color: review.userDisliked
                                        ? Color(0xFF0D40A6)
                                        : Color(0xFF7BA9EC),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    review.dislikes.toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: review.userDisliked
                                          ? Color(0xFF0D40A6)
                                          : Color(0xFF7BA9EC),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
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
        }),
      ),
    );
  }
}

// Footer NavBar and Actions
class _MiniatureFooterNavBar extends StatelessWidget {
  final VoidCallback onRemove;
  final int index;
  final ValueChanged<int> onItemSelected;

  const _MiniatureFooterNavBar({
    required this.onRemove,
    required this.index,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isMedium = MediaQuery.of(context).size.width <= 630;
    final horizontalPadding = isMedium ? 7.0 : 18.0;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(horizontalPadding, 10, horizontalPadding, 6),
      decoration: BoxDecoration(
        color: const Color(0xFF181F33),
        border: Border(top: BorderSide(color: const Color(0xFF252D44))),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: onRemove,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF232B3E),
                  surfaceTintColor: Color(0xFF1a2952),
                  shadowColor: Color(0xFF0B1936).withOpacity(0.03),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                child: const Text(
                  "Remove from Collection",
                  semanticsLabel: "Remove from Collection",
                ),
              ),
            ),
            const SizedBox(width: 13),
            // Icon navigation bar
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(_footerNavItems.length, (i) {
                  final nav = _footerNavItems[i];
                  final isSelected = index == i;
                  return Padding(
                    padding: EdgeInsets.only(
                      right: i != _footerNavItems.length - 1 ? 6.5 : 0,
                    ),
                    child: GestureDetector(
                      onTap: () => onItemSelected(i),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(2.5, 2.5, 2.5, 0),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Color(0xFF28396B)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(
                              nav.iconUrl,
                              width: 24,
                              height: 24,
                              color: isSelected
                                  ? Color(0xFF2191FB)
                                  : Color(0xFF8ca3d9),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              nav.label,
                              style: TextStyle(
                                fontSize: 12.6,
                                fontWeight: FontWeight.w700,
                                color: isSelected
                                    ? Color(0xFF2191FB)
                                    : Color(0xFF8ca3d9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterNavItem {
  final String iconUrl;
  final String label;

  _FooterNavItem(this.iconUrl, this.label);
}

// Nav Bar Items Data
List<_FooterNavItem> _footerNavItems = [
  _FooterNavItem(
    "https://app.codigma.io/api/uploads/assets/7cd20b17-d5b5-4b42-bbbe-27d8bfc14095.svg",
    "Home",
  ),
  _FooterNavItem(
    "https://app.codigma.io/api/uploads/assets/7917cd42-cf80-49d8-b6cb-405fcb993e07.svg",
    "My Collection",
  ),
  _FooterNavItem(
    "https://app.codigma.io/api/uploads/assets/c57cbe32-f868-463d-ae04-584f57d5542c.svg",
    "Add",
  ),
  _FooterNavItem(
    "https://app.codigma.io/api/uploads/assets/a7732d04-d65d-4acf-8f9f-65e0a68bdce2.svg",
    "Settings",
  ),
];

// --- Supporting Data Structures ---

class _UserReviewData {
  final String avatar;
  final String author;
  final String date;
  final List<String> stars;
  final String text;

  _UserReviewData({
    required this.avatar,
    required this.author,
    required this.date,
    required this.stars,
    required this.text,
  });
}

class ReviewInteraction {
  int likes;
  int dislikes;
  bool userLiked;
  bool userDisliked;

  ReviewInteraction({
    required this.likes,
    required this.dislikes,
    this.userLiked = false,
    this.userDisliked = false,
  });
}

class _DetailedRating {
  final int rating;
  final int percent;
  _DetailedRating({required this.rating, required this.percent});
}
