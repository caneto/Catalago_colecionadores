import 'package:flutter/material.dart';

import 'item_card.dart';

class HorizontalItemsList extends StatelessWidget {
  final List<Map<String, String>> items;
  final double width;
  final double height;
  final double imgHeight;
  final bool isScrollable;

  const HorizontalItemsList({
    super.key,
    required this.items,
    required this.width,
    required this.height,
    required this.imgHeight,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    final gap = isScrollable ? 8.0 : 16.0;

    Widget list = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < items.length; i++) ...[
          ItemCard(
            imageUrl: items[i]['image']!,
            title: items[i]['title']!,
            width: width,
            height: height,
            imageHeight: imgHeight,
          ),
          if (i != items.length - 1) SizedBox(width: gap),
        ],
      ],
    );

    if (isScrollable) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: list,
        ),
      );
    }
    return Padding(padding: const EdgeInsets.only(bottom: 4.0), child: list);
  }
}

