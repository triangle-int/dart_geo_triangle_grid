import 'lat_lng.dart';
import 'vector_3_triangle.dart';

/// A triangle defined by three [LatLng] points.
///
/// This class is used to represent a triangle on the surface of the earth.
class LatLngTriangle {
  /// The first vertex of the triangle.
  final LatLng a;

  /// The second vertex of the triangle.
  final LatLng b;

  /// The third vertex of the triangle.
  final LatLng c;

  /// Creates a new [LatLngTriangle] with the given vertices.
  LatLngTriangle(this.a, this.b, this.c);

  /// Center point of the triangle.
  LatLng get center => LatLng(
        (a.latitude + b.latitude + c.latitude) / 3,
        (a.longitude + b.longitude + c.longitude) / 3,
      );

  bool isInBounds(LatLng southwest, LatLng northeast) {
    return a.isInBounds(southwest, northeast) &&
        b.isInBounds(southwest, northeast) &&
        c.isInBounds(southwest, northeast);
  }

  bool isOnePointInBounds(LatLng southwest, LatLng northeast) {
    return a.isInBounds(southwest, northeast) ||
        b.isInBounds(southwest, northeast) ||
        c.isInBounds(southwest, northeast);
  }

  @override
  operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LatLngTriangle &&
        other.a == a &&
        other.b == b &&
        other.c == c;
  }

  /// Converts the [Vector3Triangle] to a [LatLngTriangle].
  factory LatLngTriangle.fromVector3Triangle(Vector3Triangle triangle) {
    return LatLngTriangle(
      triangle.a.toLatLng(),
      triangle.b.toLatLng(),
      triangle.c.toLatLng(),
    );
  }

  /// Converts the [LatLngTriangle] to a [Vector3Triangle].
  Vector3Triangle toVector3Triangle() {
    return Vector3Triangle.fromLatLngTriangle(this);
  }

  @override
  int get hashCode => a.hashCode ^ b.hashCode ^ c.hashCode;

  @override
  String toString() {
    return 'LatLngTriangle(a: $a, b: $b, c: $c)';
  }
}
