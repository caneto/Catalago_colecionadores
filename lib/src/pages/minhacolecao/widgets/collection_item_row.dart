import 'dart:io';

import 'package:catalago_colecionadores/src/core/database/isar_models/car_collection.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

class CollectionItemRow extends StatelessWidget {
  final CarCollection item;
  final Color surface;
  final Color brandColor;
  final Color modelColor;
  final VoidCallback onTap;

  const CollectionItemRow({
    super.key,
    required this.item,
    required this.surface,
    required this.brandColor,
    required this.modelColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "${item.marca}: ${item.nomeMiniatura}",
      child: Material(
        color: surface,
        borderRadius: BorderRadius.circular(12),
        elevation:
            0, // Flat design to match grid? Or keep elevation? Grid has no elevation but container color.
        // GridItem has no Material/elevation, just Container with color.
        // But the commented out code had Material with elevation 2. I'll stick to simple Container or Material with 0 elevation for now to match flat style if that's what Grid uses.
        // Actually GridItem uses InkWell inside Container.
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12),
                    bottom: Radius.circular(12),
                  ),
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: item.images != null && item.images!.isNotEmpty
                        ? Image.file(
                            File(item.images!.first),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stack) =>
                                Container(color: Colors.grey.shade300),
                          )
                        : item.imagePath != null && item.imagePath!.isNotEmpty
                        ? Image.file(
                            File(item.imagePath!),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stack) =>
                                Container(color: Colors.grey.shade300),
                          )
                        : Container(
                            color: Colors.grey.shade300,
                            child: const Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.categoria,
                          style: CatalagoColecionadorTheme.titleStyleNormal
                              .copyWith(
                                color: brandColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Text(
                          item.marca,
                          style: CatalagoColecionadorTheme.titleStyleNormal
                              .copyWith(
                                color: brandColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.01,
                              ),
                        ),
                        Text(
                          item.nomeMiniatura,
                          style: CatalagoColecionadorTheme.titleStyleNormal
                              .copyWith(
                                color: modelColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          item.escala,
                          style: CatalagoColecionadorTheme.titleStyleNormal
                              .copyWith(
                                color: modelColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
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
