import 'package:catalago_colecionadores/src/core/database/isar_models/car_collection.dart';
import 'package:catalago_colecionadores/src/core/database/isar_service.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:isar_community/isar.dart';

import 'widgets/miniature_gallery.dart';
import 'widgets/miniature_info_section.dart';
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
  final IsarService _isarService = IsarService();
  CarCollection? _car;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Id) {
      _loadCar(args);
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadCar(Id id) async {
    final car = await _isarService.getCarById(id);
    if (mounted) {
      setState(() {
        _car = car;
        _isLoading = false;
      });
    }
  }

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

  void _onEditPressed() async {
    if (_car == null) return;
    await Navigator.of(context).pushNamed('/add_car', arguments: _car!.id);
    _loadCar(_car!.id);
  }

  @override
  Widget build(BuildContext context) {
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
                            SizedBox(width: 4),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: _car != null ? _onEditPressed : null,
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: SvgPicture.asset(
                                      'assets/images/edit-button.svg',
                                      height: 32,
                                      width: 32,
                                      semanticsLabel: 'X',
                                      colorFilter: ColorFilter.mode(
                                        CatalagoColecionadorTheme.whiteColor,
                                        BlendMode
                                            .srcIn, // Common blend mode for single-color icons
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Semantics(
                              label: 'Editar',
                              child: InkWell(
                                onTap: _car != null ? _onEditPressed : null,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6.0,
                                    vertical: 4.0,
                                  ),
                                  child: Text(
                                    'Editar',
                                    style: CatalagoColecionadorTheme
                                        .titleStyleNormal
                                        .copyWith(
                                          color: CatalagoColecionadorTheme
                                              .whiteColor,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 17,
                                        ),
                                  ),
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
                            MiniatureGallery(images: _car?.images ?? []),
                            _isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : _car != null
                                ? MiniatureInfoSection(car: _car!)
                                : const Center(
                                    child: Text("Carro não encontrado"),
                                  ),
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
                            foregroundColor:
                                CatalagoColecionadorTheme.whiteColor,
                            backgroundColor: CatalagoColecionadorTheme.bgCard,
                            side: const BorderSide(color: Colors.blueGrey),
                          ),
                          child: Text(
                            'Remover Coleção',
                            style: CatalagoColecionadorTheme.titleStyleNormal
                                .copyWith(
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
