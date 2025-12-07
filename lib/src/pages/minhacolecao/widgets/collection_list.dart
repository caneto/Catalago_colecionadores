import 'package:flutter/material.dart';

import '../../../core/database/isar_models/car_collection.dart';
import 'collection_item_row.dart';

class CollectionList extends StatelessWidget {
  final List<CarCollection> items;
  final Color surface;
  final Color brandColor;
  final Color modelColor;

  final ValueChanged<CarCollection> onItemTap;

  const CollectionList({
    super.key,
    required this.items,
    required this.surface,
    required this.brandColor,
    required this.modelColor,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final item = items[index];
        return CollectionItemRow(
          item: item,
          surface: surface,
          brandColor: brandColor,
          modelColor: modelColor,
          onTap: () => onItemTap(item),
        );
      },
    );
  }
}
