import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Stream<Position> getCurrentLocationStream() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,  // Updates every 10 meters moved
    );
    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }

  double calculateDistance(Position currentLocation, Position staticLocation) {
    return Geolocator.distanceBetween(
      currentLocation.latitude,
      currentLocation.longitude,
      staticLocation.latitude,
      staticLocation.longitude,
    );
  }
}