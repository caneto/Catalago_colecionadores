import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final int rating;
  final int percent; // percent (ex: 40 means 40%)
  const RatingBar({super.key, required this.rating, required this.percent});

  @override
  Widget build(BuildContext context) {
    final Color fillColor1 = CatalagoColecionadorTheme.blueColor;
    final Color fillColor2 = CatalagoColecionadorTheme.cardCategyColor;
    final double maxBarWidth = 210.0;
    final double minBarWidth = 50.0;

    return Row(
      children: [
        SizedBox(
          width: 18,
          child: Text(
            rating.toString(),
            textAlign: TextAlign.right,
            style: CatalagoColecionadorTheme.titleStyle.copyWith(
              color: CatalagoColecionadorTheme.blackClaroColor,
              fontWeight: FontWeight.w600,
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
              color: CatalagoColecionadorTheme.blueFaceBook,
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
            style: CatalagoColecionadorTheme.textBold.copyWith(
              color: CatalagoColecionadorTheme.blueFaceBook,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
        ),
      ],
    );
  }
}