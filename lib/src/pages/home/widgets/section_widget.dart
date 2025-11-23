import 'package:flutter/material.dart';

class SectionWidget extends StatelessWidget {
  final Color? backGround;
  final Color borderColor;
  final EdgeInsets horizontalPadding;
  final EdgeInsets verticalPadding;
  final List<Widget> children;

  const SectionWidget({super.key, 
    this.backGround,
    required this.borderColor,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backGround,
      padding: horizontalPadding.add(verticalPadding),
      width: double.infinity,
      decoration: BoxDecoration(
        color: backGround,
        border: Border(top: BorderSide(color: borderColor, width: 1.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
