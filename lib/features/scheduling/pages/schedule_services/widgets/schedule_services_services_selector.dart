import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/app_card.dart';
import 'package:app_agendamento/core/widgets/app_check_box.dart';
import 'package:app_agendamento/features/scheduling/pages/schedule_services/schedule_services_page_cubit.dart';
import 'package:app_agendamento/features/scheduling/widgets/service_details_item.dart';
import 'package:flutter/material.dart';
import 'package:app_agendamento/core/widgets/base/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ScheduleServicesServicesSelector extends AppStateless {
  const ScheduleServicesServicesSelector({super.key});

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return BlocBuilder<ScheduleServicesPageCubit, ScheduleServicesPageState>(
      builder: (context, state) {
        final cubit = context.read<ScheduleServicesPageCubit>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Serviços',
                    style: theme.heading18Bold,
                  ),
                  Text(
                    'Selecione um ou mais serviços para avançar',
                    style: theme.body13,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (_, i) {
                final service = state.professional!.services[i];

                return AppCard(
                  shadowEnabled: false,
                  color: theme.bg,
                  onPressed: () => cubit.toggleService(service),
                  padding: const EdgeInsets.fromLTRB(10, 8, 20, 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppCheckBox(
                        checked: state.selectedServices.contains(service),
                        onTap: () => cubit.toggleService(service),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ServiceDetailsItem(service: service),
                      ),
                    ],
                  ),
                );
              },
              itemCount: state.professional!.services.length,
            ),
          ],
        );
      },
    );
  }
}