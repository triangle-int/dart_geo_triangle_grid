import 'dart:math';

import 'vector_3.dart';

/// A point on the surface of the earth.
///
/// This class is used to represent a point on the surface of the earth using
/// latitude and longitude.
class LatLng {
  /// The latitude of the point. Range is from -90 to 90.
  final double latitude;

  /// The longitude of the point. Range is from -180 to 180.
  final double longitude;

  LatLng(this.latitude, this.longitude);

  bool isInBounds(LatLng southwest, LatLng northeast) {
    return southwest.latitude <= latitude &&
        northeast.latitude >= latitude &&
        southwest.longitude <= longitude &&
        northeast.longitude >= longitude;
  }

  @override
  operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LatLng &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  /// Converts the [Vector3] to a [LatLng].
  factory LatLng.fromVector(Vector3 vector) {
    final pitch = asin(vector.z);
    final xyFactor = cos(pitch);
    final yaw = atan2(vector.y / xyFactor, vector.x / xyFactor);

    return LatLng(pitch / pi * 180, yaw / pi * 180);
  }

  /// Converts the [LatLng] to a [Vector3].
  Vector3 toVector() {
    return Vector3.fromLatLng(this);
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;

  @override
  String toString() {
    return 'LatLng(latitude: $latitude, longitude: $longitude)';
  }
}
