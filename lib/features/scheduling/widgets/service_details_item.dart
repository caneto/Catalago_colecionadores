import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/features/professional/models/service.dart';
import 'package:flutter/material.dart';
import 'package:app_agendamento/core/widgets/base/app_state.dart';
import 'package:intl/intl.dart';

class ServiceDetailsItem extends AppStateless {
  const ServiceDetailsItem({super.key, required this.service});

  final Service service;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          service.name,
          textAlign: TextAlign.start,
          style: theme.body16Bold,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                'Duração: ${service.duration} min',
                style: theme.body16,
              ),
            ),
            Text(
              NumberFormat.simpleCurrency(locale: 'pt-BR').format(service.price),
              style: theme.heading18Bold,
            ),
          ],
        )
      ],
    );
  }
}