import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/base/app_state.dart';
import 'package:app_agendamento/features/professional/models/professional.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfessionalStarWithRating extends AppStateless {
  const ProfessionalStarWithRating({super.key, required this.professional});

  final Professional professional;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: SvgPicture.asset('assets/icons/star.svg'),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            professional.rating != null ? '${professional.rating!.toStringAsFixed(1)} (${professional.ratingCount})' : '- (0)',
            style: theme.label11Bold,
          ),
        )
      ],
    );
  }
}