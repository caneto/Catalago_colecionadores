
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

import '../helpers/collection_item_data_model.dart';
import 'filter_option_widget.dart';

class FilterItemWidget extends StatefulWidget {
  final bool isMobile;
  final List<FilterItemData> filters;
  final int selectedFilter;
  final Color color;
  final Color textColor;
  final Color iconColor;

  const FilterItemWidget({
    super.key,
    this.isMobile = false,
    required this.filters,
    required this.selectedFilter,
    required this.color,
    required this.textColor,
    required this.iconColor,
  });

  @override
  State<FilterItemWidget> createState() => _FilterItemWidgetState();
}

class _FilterItemWidgetState extends State<FilterItemWidget> {
  @override
  Widget build(BuildContext context) {
    int selectedFilter = widget.selectedFilter;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          header: true,
          child: Text(
            "Filters",
            style: CatalagoColecionadorTheme.titleStyle.copyWith(
              color: CatalagoColecionadorTheme.textMain,
              fontSize: 16,
              fontWeight: FontWeight.w700,              
            ),
          ),
        ),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: List.generate(widget.filters.length, (i) {
            return FilterOptionWidget(
              data: widget.filters[i],
              selected: widget.isMobile,
              onTap: () {
                setState(() {
                  selectedFilter = selectedFilter == i ? -1 : i;
                });
              },
              color: widget.color,
              textColor: widget.textColor,
              iconColor: widget.iconColor,
            );
          }),
        ),
        // Use Wrap para permitir múltiplos por linha e quebra automática
        SizedBox(height: 4),
      ],
    );
  }
}