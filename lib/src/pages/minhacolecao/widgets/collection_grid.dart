
// -------------
// CollectionGrid
// -------------
import 'package:flutter/material.dart';

import '../../../core/database/isar_models/car_collection.dart';
import 'grid_item.dart';

class CollectionGrid extends StatelessWidget {
  final List<CarCollection> items;
  final int gridCount;
  final Color surface;
  final Color brandColor;
  final Color modelColor;

  const CollectionGrid({super.key, 
    required this.items,
    required this.gridCount,
    required this.surface,
    required this.brandColor,
    required this.modelColor,
  });

  @override
  Widget build(BuildContext context) {
    // Items are non-scrollable grid inside scrollview
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridCount,
        crossAxisSpacing: gridCount == 2
            ? 13
            : gridCount == 3
            ? 13
            : 17,
        mainAxisSpacing: gridCount == 2
            ? 15
            : gridCount == 3
            ? 15
            : 18,
        childAspectRatio:
            4 / 4.4, // as per .item: image aspect-ratio 4/3 + details
      ),
      itemBuilder: (ctx, i) => GridItem(
        item: items[i],
        surface: surface,
        brandColor: brandColor,
        modelColor: modelColor,
      ),
    );
  }
}
