import 'package:app_agendamento/core/device/app_location.dart';
import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/app_card.dart';
import 'package:app_agendamento/core/widgets/app_loading_indicator.dart';
import 'package:app_agendamento/core/widgets/base/app_stateful.dart';
import 'package:app_agendamento/features/home/pages/home/sections/home_map/home_map_section_cubit.dart';
import 'package:app_agendamento/features/home/pages/home/sections/home_map/widgets/home_map_professional_card.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeMapSection extends StatefulWidget {
  const HomeMapSection({Key? key}) : super(key: key);

  @override
  State<HomeMapSection> createState() => _HomeMapSectionState();
}

class _HomeMapSectionState extends AppState<HomeMapSection> {
  GoogleMapController? _controller;

  final HomeMapSectionCubit cubit = HomeMapSectionCubit();

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor userMarkerIcon = BitmapDescriptor.defaultMarker;

  final ScrollController scrollController = ScrollController();

  String? selectedProfessional;

  Future<void> addCustomIcon() async {
    final icons = await Future.wait([
      BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), 'assets/images/map_spot.png'),
      BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), 'assets/images/user_location.png')
    ]);
    setState(() {
      markerIcon = icons[0];
      userMarkerIcon = icons[1];
    });
  }

  @override
  void initState() {
    super.initState();

    cubit.loadUserLocation();
    Future.delayed(Duration.zero).then((value) => addCustomIcon());
  }

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return BlocProvider.value(
      value: cubit,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Profissionais em sua área',
              style: theme.body16Bold,
            ),
          ),
          const SizedBox(height: 10),
          AspectRatio(
            aspectRatio: 0.8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AppCard(
                padding: EdgeInsets.zero,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: BlocBuilder<HomeMapSectionCubit, HomeMapSectionState>(
                    builder: (context, state) {
                      if (state.locationStatus == null) {
                        return const Center(child: AppLoadingIndicator());
                      } else if (state.locationStatus !=
                          AppLocationStatus.allowed) {
                        return const Text('Localização não permitida');
                      } else if (state.userLocation == null) {
                        return const Center(child: AppLoadingIndicator());
                      } else {
                        return Stack(
                          children: [
                            GoogleMap(
                              mapType: MapType.normal,
                              initialCameraPosition: CameraPosition(
                                target: state.userLocation!.toLatLng(),
                                zoom: 14.4746,
                              ),
                              zoomControlsEnabled: false,
                              zoomGesturesEnabled: true,
                              gestureRecognizers: {
                                Factory<OneSequenceGestureRecognizer>(
                                    () => EagerGestureRecognizer())
                              },
                              markers: (state.professionals
                                      ?.map(
                                        (p) => Marker(
                                            markerId: MarkerId(p.id),
                                            position: p.location.toLatLng(),
                                            icon: markerIcon,
                                            consumeTapEvents: true,
                                            onTap: () {
                                              final index = state.professionals!
                                                  .indexOf(p);
                                              scrollController.animateTo(
                                                index * (219 + 8),
                                                duration: const Duration(
                                                  milliseconds: 300,
                                                ),
                                                curve: Curves.ease,
                                              );
                                              setState(() {
                                                selectedProfessional = p.id;
                                              });
                                            }),
                                      )
                                      .toSet() ??
                                  {})
                                ..add(
                                  Marker(
                                    markerId: const MarkerId('user'),
                                    position: state.userLocation!.toLatLng(),
                                    icon: userMarkerIcon,
                                    infoWindow:
                                        const InfoWindow(title: 'Seu local'),
                                  ),
                                ),
                              onMapCreated:
                                  (GoogleMapController controller) async {
                                _controller = controller;
                                await Future.delayed(
                                    const Duration(seconds: 1));
                                loadProfessionals();
                              },
                              onCameraIdle: () {
                                loadProfessionals();
                              },
                            ),
                            if (state.professionals != null)
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: SizedBox(
                                  height: 149,
                                  child: ListView.separated(
                                    controller: scrollController,
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.all(20),
                                    itemBuilder: (_, i) {
                                      final professional =
                                          state.professionals![i];

                                      return HomeMapProfessionalCard(
                                        professional: professional,
                                        userLocation: state.userLocation!,
                                        isSelected: professional.id == selectedProfessional
                                      );
                                    },
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(width: 8),
                                    itemCount: state.professionals!.length,
                                  ),
                                ),
                              ),
                            if (state.loadingProfessionals)
                              const Center(
                                child: AppLoadingIndicator(),
                              ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadProfessionals() async {
    EasyDebounce.debounce(
      'map-debouncer',
      const Duration(seconds: 1),
      () async {
        final region = await _controller!.getVisibleRegion();
        cubit.loadProfessionals(
          southwest: Location.fromLatLng(region.southwest),
          northeast: Location.fromLatLng(region.northeast),
        );
      },
    );
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }
}
