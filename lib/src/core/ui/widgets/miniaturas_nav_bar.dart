import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

import 'nav_bar_item.dart';

// ignore: must_be_immutable
class MiniaturasNavBar extends StatefulWidget {
  final List<Map<String, String>> items;
  int selectedIndex;
  final double navHeight;
  final double iconSize;
  final double labelFontSize;
  final double navItemWidth;

  MiniaturasNavBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.navHeight,
    required this.iconSize,
    required this.labelFontSize,
    required this.navItemWidth,
  });

  @override
  State<MiniaturasNavBar> createState() => _MiniaturasNavBarState();
}

class _MiniaturasNavBarState extends State<MiniaturasNavBar> {
  
  void onNavTapped(int idx) {
    if (idx == widget.selectedIndex) return;
    setState(() {
      widget.selectedIndex = idx;
      Navigator.of(context).pushNamed(
        idx == 0
            ? '/home'
            : idx == 1
            ? '/minha_colecao'
            : idx == 2
            ? '/add_car'
            : '/minha_colecao2',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final maxNavWidth = 480.0;
    return Material(
      elevation: 25,
      color: CatalagoColecionadorTheme.navBarBackkgroundColor,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: CatalagoColecionadorTheme.navBarBoxColor,
              width: 1,
            ),
          ),
        ),
        height: widget.navHeight,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxNavWidth),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: widget.items
                .asMap()
                .entries
                .map(
                  (e) => NavBarItem(
                    isSelected: (widget.selectedIndex == e.key) || false,
                    iconLogo: e.value['iconLogo']!,
                    label: e.value['label']!,
                    onTap: () => onNavTapped(e.key),
                    iconSize: widget.iconSize,
                    labelFontSize: widget.labelFontSize,
                    width: widget.navItemWidth,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
