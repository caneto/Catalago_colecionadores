import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum AppLocationStatus { disabled, denied, deniedForever, allowed }

class AppLocation {
  Future<AppLocationStatus> checkStatus() async {
    final isEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isEnabled) return AppLocationStatus.disabled;

    final permission = await Geolocator.checkPermission();
    return permission.toApp();
  }

  Future<AppLocationStatus> requestPermission() async {
    final isEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isEnabled) return AppLocationStatus.disabled;

    final permission = await Geolocator.requestPermission();
    return permission.toApp();
  }

  Future<Location> getLocation() async {
    final position = await Geolocator.getCurrentPosition();
    return Location.fromPosition(position);
  }
}

extension LocationPermissionX on LocationPermission {
  AppLocationStatus toApp() {
    switch (this) {
      case LocationPermission.always:
      case LocationPermission.whileInUse:
        return AppLocationStatus.allowed;
      case LocationPermission.denied:
        return AppLocationStatus.denied;
      case LocationPermission.deniedForever ||
            LocationPermission.unableToDetermine:
        return AppLocationStatus.deniedForever;
    }
  }
}

class Location {
  Location({required this.latitude, required this.longitude});

  Location.fromPosition(Position position)
      : latitude = position.latitude,
        longitude = position.longitude;

  Location.fromLatLng(LatLng latLng)
      : latitude = latLng.latitude,
        longitude = latLng.longitude;

  factory Location.fromJson(Map<String, dynamic> map) {
    return Location(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  final double latitude;
  final double longitude;

  LatLng toLatLng() => LatLng(latitude, longitude);

  @override
  String toString() {
    return '$latitude;$longitude';
  }
}
