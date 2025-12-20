import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FeatureTile extends StatelessWidget {
  final String iconUrl;
  final String title;
  final String description;
  final double titleFontSize;
  final double descFontSize;
  final bool isLast;
  final VoidCallback? onTap;

  const FeatureTile({
    super.key,
    required this.iconUrl,
    required this.title,
    required this.description,
    required this.titleFontSize,
    required this.descFontSize,
    this.isLast = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      container: true,
      label: title,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: isLast ? 0 : 14),
        decoration: BoxDecoration(
          color: CatalagoColecionadorTheme.bgInputAccent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ).copyWith(left: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Feature icon
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: SvgPicture.asset(
                    'assets/images/$iconUrl', // Path to your SVG asset
                    height: 48,
                    width: 48,
                    colorFilter: ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                    semanticsLabel: "icon",
                  ),
                ),
                // Description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w600,
                          color: CatalagoColecionadorTheme.whiteColor,
                          height: 1.14,
                          letterSpacing: -0.01,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        description,
                        style: CatalagoColecionadorTheme.titleSmallStyle.copyWith(
                          fontSize: descFontSize,
                          color: CatalagoColecionadorTheme.navBarBackkgroundColor,
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
        ),
      ),
    );
  }
}
