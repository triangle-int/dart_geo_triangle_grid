import 'lat_lng.dart';

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

  double _sign(LatLng p1, LatLng p2, LatLng p3) {
    return (p1.latitude - p3.latitude) * (p2.longitude - p3.longitude) -
        (p2.latitude - p3.latitude) * (p1.longitude - p3.longitude);
  }

  @override
  operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LatLngTriangle &&
        other.a == a &&
        other.b == b &&
        other.c == c;
  }

  @override
  int get hashCode => a.hashCode ^ b.hashCode ^ c.hashCode;

  @override
  String toString() {
    return 'LatLngTriangle(a: $a, b: $b, c: $c)';
  }
}
