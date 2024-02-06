import 'dart:math';

import 'lat_lng.dart';

/// A 3D vector. Used to represent a point in 3D space.
class Vector3 {
  /// The x component of the vector.
  final double x;

  /// The y component of the vector.
  final double y;

  /// The z component of the vector.
  final double z;

  /// Creates a new vector with the given [x], [y], and [z] components.
  Vector3(this.x, this.y, this.z);

  /// Multiply each component of the vector by [factor].
  Vector3 operator *(double factor) =>
      Vector3(x * factor, y * factor, z * factor);

  /// Divide each component of the vector by [factor].
  Vector3 operator /(double factor) =>
      Vector3(x / factor, y / factor, z / factor);

  /// Add each component of the vector by each component of [b].
  Vector3 operator +(Vector3 b) => Vector3(x + b.x, y + b.y, z + b.z);

  /// Subtract each component of the vector by each component of [b].
  Vector3 operator -(Vector3 b) => Vector3(x - b.x, y - b.y, z - b.z);

  /// Dot product of the vector and [b].
  double dot(Vector3 b) => x * b.x + y * b.y + z * b.z;

  /// Cross product of the vector and [b].
  Vector3 cross(Vector3 b) => Vector3(
        y * b.z - z * b.y,
        z * b.x - x * b.z,
        x * b.y - y * b.x,
      );

  /// The square of the length of the vector.
  double get lengthSquared => x * x + y * y + z * z;

  /// The length of the vector.
  ///
  /// Note: If you only need to compare lengths, consider using [lengthSquared] instead.
  double get length => sqrt(lengthSquared);

  /// The normalized vector (vector with length 1).
  Vector3 normalize() => this / length;

  /// Converts the [LatLng] to a [Vector3].
  factory Vector3.fromLatLng(LatLng latLng) {
    final pitch = latLng.latitude * pi / 180;
    final xyFactor = cos(pitch);
    final yaw = latLng.longitude * pi / 180;

    return Vector3(
      cos(yaw) * xyFactor,
      sin(yaw) * xyFactor,
      sin(pitch),
    );
  }

  /// Converts the [Vector3] to a [LatLng].
  LatLng toLatLng() {
    return LatLng.fromVector(this);
  }

  @override
  operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Vector3 && other.x == x && other.y == y && other.z == z;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ z.hashCode;

  @override
  String toString() {
    return 'Vector3(x: $x, y: $y, z: $z)';
  }
}
