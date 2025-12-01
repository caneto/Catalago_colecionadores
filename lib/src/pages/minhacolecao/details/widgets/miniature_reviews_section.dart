// Reviews Section
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'rating_bar.dart';

class MiniatureReviewsSection extends StatelessWidget {
  const MiniatureReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {

    // Imagens de estrelas fictícias (imite .svg em PNG, se necessário para o aplicativo real)
    final stars = [
      "star_full.svg",
      "star_full.svg",
      "star_full.svg",
      "star_full.svg",
      "star_out.svg",
    ];

    final detailedRatings = [
      DetailedRating(rating: 5, percent: 40),
      DetailedRating(rating: 4, percent: 30),
      DetailedRating(rating: 3, percent: 15),
      DetailedRating(rating: 2, percent: 10),
      DetailedRating(rating: 1, percent: 5),
    ];

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
          children: [
            Text(
              "Avaliações e comentários",
              style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                color: CatalagoColecionadorTheme.blackClaroColor,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Text(
                  "4.5",
                  style: CatalagoColecionadorTheme.textBold.copyWith(
                    color: CatalagoColecionadorTheme.blueColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -2,
                    height: 1.05,
                  ),
                  semanticsLabel: "Classificação média 4.5",
                ),
                const SizedBox(width: 13),
                Row(
                  children: stars
                      .map(
                        (star) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1.5),
                          child: SvgPicture.asset(
                            'assets/images/$star',
                            height: 18,
                            width: 18,
                            semanticsLabel: 'Estrelas',
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(width: 14),
                Text(
                  "123 avaliações",
                  style: CatalagoColecionadorTheme.textTextButtonLabel.copyWith(
                    color: CatalagoColecionadorTheme.bgCard,
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
                      child: RatingBar(rating: r.rating, percent: r.percent),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}

class DetailedRating {
  final int rating;
  final int percent;
  DetailedRating({required this.rating, required this.percent});
}
