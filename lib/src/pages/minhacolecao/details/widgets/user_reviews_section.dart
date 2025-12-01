// User Reviews Section (list of reviews)
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserReviewsSection extends StatelessWidget {
  final List<UserReviewData> reviews;
  final List<ReviewInteraction> interactions;
  final ValueChanged<int> onLike;
  final ValueChanged<int> onDislike;
  const UserReviewsSection({super.key, 
    required this.reviews,
    required this.interactions,
    required this.onLike,
    required this.onDislike,
  });

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(24, 20, 24, 18),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          border: Border(
            bottom: BorderSide(
              color: CatalagoColecionadorTheme.cardItemAndImageColor,
            ),
          ),
        ),
      
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
                        color: CatalagoColecionadorTheme.blackClaroColor,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          width: 1.25,
                          color: CatalagoColecionadorTheme.blackClaroColor,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.asset(
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
                          style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                            fontSize: 15.5,
                            color: CatalagoColecionadorTheme.blackClaroColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          r.date,
                          style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                            color: CatalagoColecionadorTheme.cardCategyColor,
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
                                  child: SvgPicture.asset(
                                    'assets/images/$star',
                                    height: 16,
                                    width: 16,
                                    semanticsLabel: 'Estrelas',
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          r.text,
                          style: CatalagoColecionadorTheme.titleStyle.copyWith(
                            fontSize: 15,
                            color: CatalagoColecionadorTheme.bgCard,
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
                                    SvgPicture.asset(
                                      'assets/images/curtido.svg',
                                      height: 16,
                                      width: 16,
                                      semanticsLabel: 'Curtido',
                                      colorFilter: ColorFilter.mode(
                                        review.userLiked
                                            ? CatalagoColecionadorTheme.blueColor
                                            : CatalagoColecionadorTheme
                                                  .cardCategyColor,
                                        BlendMode
                                            .srcIn, // Common blend mode for single-color icons
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      review.likes.toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: review.userLiked
                                            ? CatalagoColecionadorTheme.blueColor
                                            : CatalagoColecionadorTheme
                                                  .cardCategyColor,
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
                                    SvgPicture.asset(
                                      'assets/images/descurtido.svg',
                                      height: 16,
                                      width: 16,
                                      semanticsLabel: 'Curtido',
                                      colorFilter: ColorFilter.mode(
                                        review.userLiked
                                            ? CatalagoColecionadorTheme.blueColor
                                            : CatalagoColecionadorTheme
                                                  .cardCategyColor,
                                        BlendMode
                                            .srcIn, // Common blend mode for single-color icons
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      review.dislikes.toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: review.userDisliked
                                            ? CatalagoColecionadorTheme.blueColor
                                            : CatalagoColecionadorTheme
                                                  .cardCategyColor,
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
      ),
    );
  }
}

class UserReviewData {
  final String avatar;
  final String author;
  final String date;
  final List<String> stars;
  final String text;

  UserReviewData({
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
