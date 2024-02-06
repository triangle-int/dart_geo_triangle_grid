import 'dart:math';

import 'vector_3.dart';

class LatLng {
  final double latitude;
  final double longitude;

  LatLng(this.latitude, this.longitude);

  @override
  operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LatLng &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  factory LatLng.fromVector(Vector3 vector) {
    final pitch = asin(vector.z);
    final xyFactor = cos(pitch);
    final yaw = atan2(vector.y / xyFactor, vector.x / xyFactor);

    return LatLng(pitch / pi * 180, yaw / pi * 180);
  }

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
