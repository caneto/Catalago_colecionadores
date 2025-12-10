import 'package:catalago_colecionadores/src/core/database/isar_models/car_base_collection.dart';
import 'package:catalago_colecionadores/src/core/database/isar_service.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

import 'grid_item.dart';

class NovidadesItemsList extends StatelessWidget {
  final double width;
  final double height;
  final double imgHeight;
  final bool isScrollable;

  const NovidadesItemsList({
    super.key,
    required this.width,
    required this.height,
    required this.imgHeight,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CarBaseCollection>>(
      future: IsarService().getAllCarsBase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar novidades'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink(); // Or some placeholder
        }

        final items = snapshot.data!;
        // Show only latest 5 or so? The user didn't specify limit, but usually "novidades" implies latest.
        // Assuming getAllCarsBase returns all, we might want to reverse or sort.
        // For now, let's just show them as is, maybe reversed to show newest added if auto-increment works that way.
        // Actually, let's just show them.

        final gap = isScrollable ? 8.0 : 16.0;

        Widget list = SizedBox(
          height: height,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (context, index) => SizedBox(width: gap),
            itemBuilder: (context, index) {
              final item = items[index];
              return SizedBox(
                width: width,
                child: GridItem(
                  item: item,
                  surface: CatalagoColecionadorTheme.bgCard,
                  brandColor: CatalagoColecionadorTheme.whiteColor,
                  modelColor: CatalagoColecionadorTheme.navBarBackkgroundColor,
                  onTap: () {
                    // The user replaced 'novidades_item_list' with 'grid_item' and said "lendo os dados...".
                    // User didn't specify what happens on tap.
                    // But GridItem requires onTap.
                    // I will leave it empty or maybe navigate to detail if applicable?
                    // Current `novidades_items_list` used `ItemCard` which didn't seem to have onTap in the list usage, but `GridItem` does.
                    // I'll add a print for now or maybe existing logic if any.
                  },
                ),
              );
            },
          ),
        );

        if (isScrollable) {
          // Already using ListView which is scrollable.
          return list;
        }

        // If not scrollable (meaning grid?), the original code used Row.
        // But here we are fetching potentially many items. Horizontal scroll makes sense for "Novidades".
        // The original logic `if (isScrollable)` wrapped it in SingleChildScrollView.
        // I will stick to horizontal ListView which is standard for such sections.
        return list;
      },
    );
  }
}
