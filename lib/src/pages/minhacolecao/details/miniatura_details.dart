import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'widgets/miniature_Info_section.dart';
import 'widgets/miniature_gallery.dart';
import 'widgets/miniature_reviews_section.dart';
import 'widgets/user_reviews_section.dart';

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

  // Gallery image list
  final List<String> galleryImages = [
    "assets/images/carro_ford_mustang.png",
    "assets/images/carro_ford_mustang.png",
    "assets/images/carro_ford_mustang.png",
  ];

  final String mainImage =
      "https://app.codigma.io/api/uploads/assets/bd7e40e4-e070-4638-bd63-bd463ddf176e.png";

  // Reviews Data (English only, as per instruction; originals are in PT)
  final List<UserReviewData> userReviews = [
    UserReviewData(
      avatar: "assets/images/user2.png",
      author: "Lucas Silva",
      date: "2 weeks ago",
      stars: [
        "star_full.svg",
        "star_full.svg",
        "star_full.svg",
        "star_full.svg",
        "star_out.svg",
      ],
      text:
          "This miniature is amazing! The quality of the details is impressive and the painting is perfect. An essential item for any collector.",
    ),
    UserReviewData(
      avatar: "assets/images/user1.png",
      author: "Mariana Costa",
      date: "1 month ago",
      stars: [
        "star_full.svg",
        "star_full.svg",
        "star_full.svg",
        "star_full.svg",
        "star_out.svg",
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
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
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
                              color: CatalagoColecionadorTheme.barColor,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              child: SvgPicture.asset(
                                'assets/images/seta_esquerda.svg',
                                height: 28,
                                width: 28,
                              ),
                              onTap: () => Navigator.pop(context),
                            ),
                            const SizedBox(width: 8),
                            Semantics(
                              header: true,
                              child: Text(
                                'Detalhes da Miniatura',
                                style: CatalagoColecionadorTheme.titleStyle
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      letterSpacing: -0.01,
                                      color:
                                          CatalagoColecionadorTheme.whiteColor,
                                    ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: AlignmentGeometry.centerRight,
                                child: InkWell(
                                  child: SvgPicture.asset(
                                    'assets/images/x.svg',
                                    height: 32,
                                    width: 32,
                                    colorFilter: ColorFilter.mode(
                                      CatalagoColecionadorTheme.whiteColor,
                                      BlendMode.srcATop,
                                    ),
                                    semanticsLabel: 'X',
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            MiniatureGallery(images: galleryImages),
                            MiniatureInfoSection(),
                            MiniatureReviewsSection(),
                            UserReviewsSection(
                              reviews: userReviews,
                              interactions: reviewInteractions,
                              onLike: (i) {
                                setState(() {
                                  //       // Simple toggle logic; update counts accordingly
                                  if (!reviewInteractions[i].userLiked) {
                                    reviewInteractions[i].likes++;
                                    if (reviewInteractions[i].userDisliked) {
                                      reviewInteractions[i].dislikes--;
                                      reviewInteractions[i].userDisliked =
                                          false;
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
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: sizeOf.width * .94,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () async {},
                          style: ElevatedButton.styleFrom(
                            foregroundColor: CatalagoColecionadorTheme.whiteColor,
                            backgroundColor: CatalagoColecionadorTheme.bgCard,
                            side: const BorderSide(color: Colors.blueGrey),
                          ),
                          child: Text(
                            'Remover Coleção',
                            style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                              color: CatalagoColecionadorTheme.whiteColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
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
