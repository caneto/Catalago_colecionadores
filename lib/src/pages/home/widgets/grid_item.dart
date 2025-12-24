import 'dart:convert';

import 'package:catalago_colecionadores/src/core/database/isar_models/car_base_collection.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GridItem extends StatelessWidget {
  final CarBaseCollection item;
  final Color surface;
  final Color brandColor;
  final Color modelColor;
  final VoidCallback onTap;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;

  const GridItem({
    super.key,
    required this.item,
    required this.surface,
    required this.brandColor,
    required this.modelColor,
    required this.onTap,
    this.isFavorite = false,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    String nomeMiniatura = item.nomeMiniatura.length <= 32
        ? item.nomeMiniatura
        : '${item.nomeMiniatura.substring(0, 30)}...';

    return InkWell(
      onTap: onTap,
      child: Semantics(
        label: '${item.marca}, ${item.nomeMiniatura}',
        child: Container(
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: 4 / 3,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                  child: item.gallery.isNotEmpty
                      ? Image.memory(
                          base64Decode(item.gallery.first.imageBase64),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stack) =>
                              Container(color: Colors.grey.shade300),
                        )
                      : Container(
                          color: Colors.grey.shade300,
                          child: const Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                          ),
                        ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        item.marca,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 1.18,
                          letterSpacing: -0.01,
                          color: brandColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        nomeMiniatura,
                        style: CatalagoColecionadorTheme.titleStyleNormal
                            .copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 1.13,
                              letterSpacing: -0.01,
                              color: modelColor,
                            ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          // Star Icon
                          GestureDetector(
                            onTap: onFavoriteToggle,
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: isFavorite
                                    ? CatalagoColecionadorTheme.bgInputAccent
                                    : Colors.grey.shade300,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                'assets/images/full_star.svg',
                                width: 19,
                                height: 19,
                                colorFilter: ColorFilter.mode(
                                  CatalagoColecionadorTheme.whiteColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (item.linha.isNotEmpty) ...[
                            Container(
                              height: 28,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    CatalagoColecionadorTheme.blackLightGround,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                item.linha,
                                style: CatalagoColecionadorTheme
                                    .titleStyleNormal
                                    .copyWith(
                                      color:
                                          CatalagoColecionadorTheme.whiteColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                          // Date
                          if (item.anoFabricacao != null) ...[
                            Container(
                              height: 28,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    CatalagoColecionadorTheme.blackLightGround,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${item.anoFabricacao}',
                                style: CatalagoColecionadorTheme
                                    .titleStyleNormal
                                    .copyWith(
                                      color:
                                          CatalagoColecionadorTheme.whiteColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
