import 'dart:math';

import 'package:geolocator/geolocator.dart';

class GeoUtils {

  static bool isWithin50Meters(double lat1, double lon1, double lat2, double lon2) {
    double distance = Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
    return distance <= 50.0;
  }
}