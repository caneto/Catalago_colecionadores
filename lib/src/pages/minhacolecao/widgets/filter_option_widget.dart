import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../helpers/collection_item_data_model.dart';

class FilterOptionWidget extends StatelessWidget {
  final FilterItemData data;
  final bool selected;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;
  final Color iconColor;

  const FilterOptionWidget({
    super.key,
    required this.data,
    required this.selected,
    required this.onTap,
    required this.color,
    required this.textColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: data.label,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Open $data.label filter (Not implemented)"),
            ),
          );
        },
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          curve: Curves.ease,
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
          decoration: BoxDecoration(
            color: selected
                ? color.withValues(alpha: 0.94)
                : color, // Feedback when selected
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize:
                MainAxisSize.min, // deixa a Row ocupar só o necessário
            children: [
              Text(
                data.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: -0.01,
                ),
              ),
              if (data.iconUrl != null) ...[
                const SizedBox(width: 10),
                SizedBox(
                  height: 18,
                  width: 18,
                  child: SvgPicture.asset(
                    'assets/images/seta_filter.svg', // Path to your SVG asset
                    semanticsLabel: 'X',
                  ), //Image.network(data.iconUrl!, fit: BoxFit.contain),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
