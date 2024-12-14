import 'package:geolocator/geolocator.dart';
import 'dart:math' as math;
class Location {
  final double latitude;
  final double longitude;
  final String name;
  static List<Location> positions = [
    // Akaki
    Location("Akaki Kality", 8.871546, 38.788999),
    Location("Nefas Silk", 8.948606, 38.7649),
    Location("Bethel", 9.006456, 38.681882),
    Location("Kirkos", 8.973223, 38.760955),
    Location("Main", 9.05759, 38.713312),
    Location("Addis Ketema", 9.033437, 38.724256),
    Location("Addis HeadQuarter", 9.037573, 38.75321),
    Location("Arada", 9.037687, 38.753776),
     Location("Tigist", 9.05759, 38.713312),
  ];

  Location(this.name, this.latitude, this.longitude);

  double calculateDistance(Location other) {
    final double lat1 = degreesToRadians(latitude);
    final double lon1 = degreesToRadians(longitude);
    final double lat2 = degreesToRadians(other.latitude);
    final double lon2 = degreesToRadians(other.longitude);

    const double R = 6371e3; // Earth's radius in meters

    final double dLat = lat2 - lat1;
    final double dLon = lon2 - lon1;

    final double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1) *
            math.cos(lat2) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return R * c;
  }

  static double degreesToRadians(double degrees) {
    return degrees * math.pi / 180;
  }
}

List<Location> sortLocationsByDistance(
    Position userLocation, List<Location> positions ) {
  final sortedLocations = positions.map((location) {
    final distance = location.calculateDistance(
        Location('',userLocation.latitude, userLocation.longitude));
    return {'location': location, 'distance': distance};
  }).toList();

  // sorting function
  sortedLocations.sort(
      (a, b) => (a['distance'] as double).compareTo(b['distance'] as double));

  return sortedLocations.map((item) => item['location'] as Location).toList();
}

