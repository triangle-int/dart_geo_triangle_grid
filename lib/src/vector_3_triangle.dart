import 'lat_lng_triangle.dart';
import 'vector_3.dart';

class Vector3Triangle {
  final Vector3 a;
  final Vector3 b;
  final Vector3 c;

  Vector3Triangle(this.a, this.b, this.c);

  /// Returns `true` if [vector] is inside the triangle.
  bool contains(Vector3 vector) {
    final vertices = [a, b, c];
    for (var i = 0; i < 3; i++) {
      final normal = vertices[i].cross(vertices[(i + 1) % 3]);

      if (normal.dot(vector) > 0) return false;
    }
    return true;
  }

  /// Subdivides the triangle into 4 smaller triangles.
  List<Vector3Triangle> subdivide() {
    final vertices = [a, b, c];
    final middles = [0, 1, 2]
        .map((i) => ((vertices[i] + vertices[(i + 1) % 3])).normalize())
        .toList();
    return [
      Vector3Triangle(vertices[0], middles[0], middles[2]),
      Vector3Triangle(vertices[1], middles[1], middles[0]),
      Vector3Triangle(vertices[2], middles[2], middles[1]),
      Vector3Triangle(middles[0], middles[1], middles[2]),
    ];
  }

  factory Vector3Triangle.fromLatLngTriangle(LatLngTriangle triangle) {
    return Vector3Triangle(
      Vector3.fromLatLng(triangle.a),
      Vector3.fromLatLng(triangle.b),
      Vector3.fromLatLng(triangle.c),
    );
  }

  LatLngTriangle toLatLngTriangle() {
    return LatLngTriangle.fromVector3Triangle(this);
  }

  @override
  operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Vector3Triangle &&
        other.a == a &&
        other.b == b &&
        other.c == c;
  }

  @override
  int get hashCode => a.hashCode ^ b.hashCode ^ c.hashCode;

  @override
  String toString() {
    return 'Vector3Triangle(a: $a, b: $b, c: $c)';
  }
}
