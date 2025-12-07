import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// --- CIRCLE ICON WIDGET ---
class CircleIcon extends StatelessWidget {
  final String url;
  final double size;

  const CircleIcon({super.key, required this.url, required this.size});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "icon",
      child: SvgPicture.asset(
        'assets/images/$url', // Path to your SVG asset
        height: size,
        width: size,
        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        semanticsLabel: "icon",
      ),
    );
  }
}
