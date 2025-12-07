import 'dart:io';

import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/database/isar_models/car_collection.dart';

class GridItem extends StatelessWidget {
  final CarCollection item;
  final Color surface;
  final Color brandColor;
  final Color modelColor;
  final VoidCallback onTap;

  const GridItem({
    super.key,
    required this.item,
    required this.surface,
    required this.brandColor,
    required this.modelColor,
    required this.onTap,
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
                  child: item.images != null && item.images!.isNotEmpty
                      ? Image.file(
                          File(item.images!.first),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stack) =>
                              Container(color: Colors.grey.shade300),
                        )
                      : item.imagePath != null && item.imagePath!.isNotEmpty
                      ? Image.file(
                          File(item.imagePath!),
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
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
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
                        style: TextStyle(
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
                          // Copies Count
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: CatalagoColecionadorTheme.bgInputAccent,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              (item.numeroCopias ?? 1).toString(),
                              style: const TextStyle(
                                color: CatalagoColecionadorTheme.whiteColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Star Icon
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: CatalagoColecionadorTheme.bgInputAccent,
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
                          const SizedBox(width: 8),
                          // Date
                          if (item.anoFabricacao != null) ...[
                            Container(
                              height: 28,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color: CatalagoColecionadorTheme.bgInputAccent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${item.anoFabricacao}',
                                style: const TextStyle(
                                  color: Colors.white,
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
