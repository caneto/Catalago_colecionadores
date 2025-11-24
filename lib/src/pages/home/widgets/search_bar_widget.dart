// SearchBar
// -------------
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchBarWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;
  final String hint;
  final ValueChanged<String> onChanged;

  const SearchBarWidget({
    super.key,
    required this.backgroundColor,
    required this.iconColor,
    required this.textColor,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Mulit-row text field not required here; single-line suffices
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(9),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Row(
        children: [
          SizedBox(
            height: 22,
            width: 22,
            child: SvgPicture.asset(
              'assets/images/lupa.svg',
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              semanticsLabel: 'Search Icon',
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: TextField(
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Color(0xFFC99194),
                letterSpacing: 0.01,
                height: 1.3,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(
                  color: textColor.withValues(alpha: 0.72),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  letterSpacing: 0.01,
                ),
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: onChanged,
              enableSuggestions: false,
              autocorrect: false,
            ),
          ),
        ],
      ),
    );
  }
}
