import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/base/app_state.dart';
import 'package:app_agendamento/features/professional/models/professional.dart';
import 'package:flutter/material.dart';

class ProfessionalProfilePicture extends AppStateless {
  const ProfessionalProfilePicture({super.key, required this.professional, this.size = 60});

  final Professional professional;
  final double size;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: theme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        image: professional.picture != null
            ? DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            professional.picture!,
          ),
        )
            : null,
      ),
      child: professional.picture != null
          ? null
          : Icon(
        Icons.person_outline,
        color: theme.primary,
      ),
    );
  }
}
