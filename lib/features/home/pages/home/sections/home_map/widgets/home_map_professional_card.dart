import 'package:app_agendamento/core/device/app_location.dart';
import 'package:app_agendamento/core/route/app_routes.dart';
import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/app_card.dart';
import 'package:app_agendamento/core/widgets/base/app_state.dart';
import 'package:app_agendamento/features/professional/models/professional_details.dart';
import 'package:app_agendamento/features/professional/widgets/professional_profile_picture.dart';
import 'package:app_agendamento/features/professional/widgets/professional_star_with_rating.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

class HomeMapProfessionalCard extends AppStateless {
  const HomeMapProfessionalCard({
    super.key,
    required this.professional,
    required this.userLocation,
    required this.isSelected,
  });

  final ProfessionalDetails professional;
  final Location userLocation;
  final bool isSelected;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return AppCard(
      onPressed: () {
        context.push(
          AppRoutes.professionalDetails.fullPath(id: professional.id),
        );
      },
      color: isSelected ? const Color(0xffE4DEFF) : Colors.white,
      width: 219,
      padding: const EdgeInsets.all(16),
      shadowEnabled: false,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfessionalProfilePicture(
                professional: professional,
                size: 50,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      professional.name,
                      textAlign: TextAlign.end,
                      style: theme.body16Bold,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      professional.specialties.map((e) => e.name).join(' | '),
                      style: theme.body13.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.gray,
                      ),
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: ProfessionalStarWithRating(
                  professional: professional,
                ),
              ),
              RichText(
                text: TextSpan(
                  style: theme.body13Bold,
                  children: [
                    const TextSpan(
                      text: 'a ',
                    ),
                    TextSpan(
                      text: '${(Geolocator.distanceBetween(
                            professional.location.latitude,
                            professional.location.longitude,
                            userLocation.latitude,
                            userLocation.longitude,
                          ) / 1000).toStringAsFixed(1)}km',
                      style: theme.body13Bold.copyWith(
                        color: theme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
