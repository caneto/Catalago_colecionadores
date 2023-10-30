part of 'home_map_section_cubit.dart';

class HomeMapSectionState extends Equatable {
  const HomeMapSectionState({
    required this.userLocation,
    required this.locationStatus,
    required this.professionals,
    required this.loadingProfessionals,
  });

  const HomeMapSectionState.initial()
      : userLocation = null,
        locationStatus = null,
        professionals = null,
        loadingProfessionals = false;

  final AppLocationStatus? locationStatus;
  final Location? userLocation;
  final List<ProfessionalDetails>? professionals;
  final bool loadingProfessionals;

  @override
  List<Object?> get props => [userLocation, locationStatus, professionals, loadingProfessionals];

  HomeMapSectionState copyWith({
    AppLocationStatus? locationStatus,
    Location? userLocation,
    List<ProfessionalDetails>? professionals,
    bool? loadingProfessionals,
  }) {
    return HomeMapSectionState(
      locationStatus: locationStatus ?? this.locationStatus,
      userLocation: userLocation ?? this.userLocation,
      professionals: professionals ?? this.professionals,
      loadingProfessionals: loadingProfessionals ?? this.loadingProfessionals,
    );
  }
}
