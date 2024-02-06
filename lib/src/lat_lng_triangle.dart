import 'lat_lng.dart';
import 'vector_3_triangle.dart';

class LatLngTriangle {
  final LatLng a;
  final LatLng b;
  final LatLng c;

  LatLngTriangle(this.a, this.b, this.c);

  /// Center point of the triangle.
  LatLng get center => LatLng(
        (a.latitude + b.latitude + c.latitude) / 3,
        (a.longitude + b.longitude + c.longitude) / 3,
      );

  @override
  operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LatLngTriangle &&
        other.a == a &&
        other.b == b &&
        other.c == c;
  }

  factory LatLngTriangle.fromVector3Triangle(Vector3Triangle triangle) {
    return LatLngTriangle(
      triangle.a.toLatLng(),
      triangle.b.toLatLng(),
      triangle.c.toLatLng(),
    );
  }

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
