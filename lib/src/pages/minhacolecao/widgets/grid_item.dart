
import 'package:flutter/material.dart';

import '../helpers/collection_item_data_model.dart';

class GridItem extends StatelessWidget {
  final CollectionItemData item;
  final Color surface;
  final Color brandColor;
  final Color modelColor;

  const GridItem({super.key, 
    required this.item,
    required this.surface,
    required this.brandColor,
    required this.modelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${item.brand}, ${item.model}',
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
                child: Image.network(
                  item.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stack) =>
                      Container(color: Colors.grey.shade300),
                  // Avoids unhandled exceptions
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 11),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.brand,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.18,
                      letterSpacing: -0.01,
                      color: brandColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.model,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.12,
                      letterSpacing: -0.01,
                      color: modelColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
