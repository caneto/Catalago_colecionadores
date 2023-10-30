import 'package:app_agendamento/core/route/app_routes.dart';
import 'package:app_agendamento/features/professional/models/professional.dart';
import 'package:app_agendamento/features/professional/widgets/professional_profile_picture.dart';
import 'package:app_agendamento/features/professional/widgets/professional_star_with_rating.dart';
import 'package:flutter/material.dart';

import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/base/app_state.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ProfessionalBasicInfoArea extends AppStateless {
  const ProfessionalBasicInfoArea(
      {super.key, required this.professional, this.enableTap = true});

  final Professional professional;
  final bool enableTap;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return InkWell(
      onTap: enableTap
          ? () {
              context.push(
                  AppRoutes.professionalDetails.fullPath(id: professional.id));
            }
          : null,
      child: Row(
        children: [
          ProfessionalProfilePicture(professional: professional),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  professional.name,
                  style: theme.body16Bold,
                ),
                const SizedBox(height: 4),
                ProfessionalStarWithRating(
                  professional: professional,
                ),
                const SizedBox(height: 4),
                Text(
                  'CRM: ${professional.crm}',
                  style: theme.label11,
                )
              ],
            ),
          ),
          if (enableTap)
            SvgPicture.asset(
              'assets/icons/chevron_right.svg',
            ),
        ],
      ),
    );
  }
}
