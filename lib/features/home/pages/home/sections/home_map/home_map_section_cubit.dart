import 'package:app_agendamento/core/device/app_location.dart';
import 'package:app_agendamento/core/di/di.dart';
import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/features/professional/data/professional_repository.dart';
import 'package:app_agendamento/features/professional/models/professional_details.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_map_section_state.dart';

class HomeMapSectionCubit extends Cubit<HomeMapSectionState> {
  HomeMapSectionCubit({AppLocation? appLocation, ProfessionalRepository? professionalRepository})
      : _appLocation = appLocation ?? getIt(),
        _professionalRepository = professionalRepository ?? getIt(),
        super(const HomeMapSectionState.initial());

  final AppLocation _appLocation;
  final ProfessionalRepository _professionalRepository;

  Future<void> loadUserLocation() async {
    final status = await _appLocation.checkStatus();
    emit(state.copyWith(locationStatus: status));
    if(status == AppLocationStatus.allowed) {
      final location = await _appLocation.getLocation();
      emit(state.copyWith(userLocation: location));
    }
  }

  Future<void> loadProfessionals({required Location southwest, required Location northeast}) async {
    emit(state.copyWith(loadingProfessionals: true));
    final result = await _professionalRepository.getProfessionals(southwest: southwest, northeast: northeast);
    if(result case Success(object: final professionals)) {
      emit(state.copyWith(professionals: professionals, loadingProfessionals: false));
    } else {
      emit(state.copyWith(loadingProfessionals: false));
    }
  }
}
