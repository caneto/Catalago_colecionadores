// -------------
// CollectionGrid
// -------------
import 'package:flutter/material.dart';

import '../../../core/database/isar_models/car_collection.dart';
import 'grid_item.dart';

class CollectionGrid extends StatelessWidget {
  final List<CarCollection> items;
  final Map<String, int> counts;
  final int gridCount;
  final Color surface;
  final Color brandColor;
  final Color modelColor;

  final ValueChanged<CarCollection> onItemTap;

  const CollectionGrid({
    super.key,
    required this.items,
    required this.counts,
    required this.gridCount,
    required this.surface,
    required this.brandColor,
    required this.modelColor,
    required this.onItemTap,
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
        childAspectRatio: 0.75, // Adjusted to fit new content (badges)
      ),
      itemBuilder: (ctx, i) {
        final item = items[i];
        final count = counts[item.nomeMiniatura] ?? 1;

        return GridItem(
          item: item,
          count: count,
          surface: surface,
          brandColor: brandColor,
          modelColor: modelColor,
          onTap: () => onItemTap(items[i]),
        );
      },
    );
  }
}
