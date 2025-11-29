// ignore: must_be_immutable
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'circle_icon.dart';

// ignore: must_be_immutable
class ConfigDetailCard extends StatefulWidget {
  final String iconUrl;
  final String title;
  final String? subtitle;
  final double? marginBottom;
  final bool? withIcon;
  final bool? switchActivity;
  bool lightTheme;

  ConfigDetailCard({
    super.key,
    required this.iconUrl,
    required this.title,
    this.subtitle,
    this.marginBottom = 9,
    this.withIcon = false,
    this.switchActivity = false,
    this.lightTheme = true,
  });

  @override
  State<ConfigDetailCard> createState() => ConfigDetailCardState();
}

class ConfigDetailCardState extends State<ConfigDetailCard> {
  WidgetStateProperty<Color?> trackColor = WidgetStateProperty<Color?>.fromMap(
    <WidgetStatesConstraint, Color>{WidgetState.selected: Colors.lightBlue},
  );
  final WidgetStateProperty<Color?> overlayColor =
      WidgetStateProperty<Color?>.fromMap(<WidgetState, Color>{
        WidgetState.selected: Colors.lightBlue.withValues(alpha: 0.54),
        WidgetState.disabled: Colors.grey.shade400,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: widget.marginBottom ?? 9),
      decoration: BoxDecoration(
        color: CatalagoColecionadorTheme.bgCard,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleIcon(url: widget.iconUrl, size: 37),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: CatalagoColecionadorTheme.titleSmallStyle.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: CatalagoColecionadorTheme.whiteColor,
                    height: 20 / 15,
                  ),
                  semanticsLabel: widget.title,
                ),
                if (widget.subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 1.5),
                    child: Text(
                      widget.subtitle!,
                      style: CatalagoColecionadorTheme.titleSmallStyle.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: CatalagoColecionadorTheme.navBarBackkgroundColor,
                      ),
                      semanticsLabel: widget.subtitle,
                    ),
                  ),
              ],
            ),
          ),
          if (widget.withIcon ?? false)
            Align(
              alignment: AlignmentGeometry.centerRight,
              child: SvgPicture.asset(
                'assets/images/seta_direita.svg',
                height: 28,
                width: 28,
              ),
            ),
          if (widget.switchActivity ?? false)
            Switch(
              value: widget.lightTheme,
              overlayColor: overlayColor,
              trackColor: trackColor,
              thumbColor: const WidgetStatePropertyAll<Color>(Colors.black),
              onChanged: (bool value) {
                setState(() {
                  widget.lightTheme = value;
                });
              },
            ),
        ],
      ),
    );
  }
}
