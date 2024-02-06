import 'dart:math';

import 'lat_lng.dart';
import 'lat_lng_triangle.dart';
import 'vector_3.dart';
import 'vector_3_triangle.dart';

final phi = (1 + sqrt(5)) / 2;
final magnitude = 1 / sqrt(1 + pow(phi, 2));
final x = 1 * magnitude;
final z = phi * magnitude;
const n = 0.0;
final icosphereVerts = [
  Vector3(-x, n, z),
  Vector3(x, n, z),
  Vector3(-x, n, -z),
  Vector3(x, n, -z),
  Vector3(n, z, x),
  Vector3(n, z, -x),
  Vector3(n, -z, x),
  Vector3(n, -z, -x),
  Vector3(z, x, n),
  Vector3(-z, x, n),
  Vector3(z, -x, n),
  Vector3(-z, -x, n),
];
final icosphereTriangles = [
  Vector3Triangle(icosphereVerts[0], icosphereVerts[4], icosphereVerts[1]),
  Vector3Triangle(icosphereVerts[0], icosphereVerts[9], icosphereVerts[4]),
  Vector3Triangle(icosphereVerts[9], icosphereVerts[5], icosphereVerts[4]),
  Vector3Triangle(icosphereVerts[4], icosphereVerts[5], icosphereVerts[8]),
  //
  Vector3Triangle(icosphereVerts[4], icosphereVerts[8], icosphereVerts[1]),
  Vector3Triangle(icosphereVerts[8], icosphereVerts[10], icosphereVerts[1]),
  Vector3Triangle(icosphereVerts[8], icosphereVerts[3], icosphereVerts[10]),
  Vector3Triangle(icosphereVerts[5], icosphereVerts[3], icosphereVerts[8]),
  //
  Vector3Triangle(icosphereVerts[5], icosphereVerts[2], icosphereVerts[3]),
  Vector3Triangle(icosphereVerts[2], icosphereVerts[7], icosphereVerts[3]),
  Vector3Triangle(icosphereVerts[7], icosphereVerts[10], icosphereVerts[3]),
  Vector3Triangle(icosphereVerts[7], icosphereVerts[6], icosphereVerts[10]),
  //
  Vector3Triangle(icosphereVerts[7], icosphereVerts[11], icosphereVerts[6]),
  Vector3Triangle(icosphereVerts[11], icosphereVerts[0], icosphereVerts[6]),
  Vector3Triangle(icosphereVerts[0], icosphereVerts[1], icosphereVerts[6]),
  Vector3Triangle(icosphereVerts[6], icosphereVerts[1], icosphereVerts[10]),
  //
  Vector3Triangle(icosphereVerts[9], icosphereVerts[0], icosphereVerts[11]),
  Vector3Triangle(icosphereVerts[9], icosphereVerts[11], icosphereVerts[2]),
  Vector3Triangle(icosphereVerts[9], icosphereVerts[2], icosphereVerts[5]),
  Vector3Triangle(icosphereVerts[7], icosphereVerts[2], icosphereVerts[11]),
];

class TriangleGrid {
  int _findContainingTriangle(List<Vector3Triangle> triangles, Vector3 vector) {
    return triangles.indexWhere((tri) => tri.contains(vector));
  }

  String _vectorToHashTriangles(
    List<Vector3Triangle> triangles,
    Vector3 vector,
    int depth,
  ) {
    if (depth <= 0) {
      return '';
    }

    final index = _findContainingTriangle(triangles, vector);
    final next = triangles[index].subdivide();
    final nextHash = _vectorToHashTriangles(next, vector, depth - 1);
    return index.toString() + nextHash;
  }

  String _vectorToHash(Vector3 vector, int depth) {
    final firstIndex = _findContainingTriangle(icosphereTriangles, vector);
    final next = icosphereTriangles[firstIndex].subdivide();
    final hashRest = _vectorToHashTriangles(next, vector, depth - 1);
    return String.fromCharCode('A'.codeUnits[0] + firstIndex) + hashRest;
  }

  Vector3Triangle _hashToTriangle(Vector3Triangle triangle, String hash) {
    if (hash.isEmpty) {
      return triangle;
    }

    final next = triangle.subdivide()[int.parse(hash[0])];
    return _hashToTriangle(next, hash.substring(1));
  }

  Vector3Triangle _hashToTriangleRoot(String hash) {
    final initialIndex = hash.codeUnits[0] - 'A'.codeUnits[0];
    final initial = icosphereTriangles[initialIndex];
    return _hashToTriangle(initial, hash.substring(1));
  }

  Vector3 _hashToVector(String hash) {
    final triangle = _hashToTriangleRoot(hash);
    return (triangle.a + triangle.b + triangle.c) / 3;
  }

  String latLngToHash(LatLng latLng, [int depth = 20]) {
    return _vectorToHash(Vector3.fromLatLng(latLng), depth);
  }

  LatLng hashToLatLng(String hash) {
    return _hashToVector(hash).toLatLng();
  }

  LatLngTriangle hashToLatLngTriangle(String hash) {
    final triangle = _hashToTriangleRoot(hash);
    return LatLngTriangle.fromVector3Triangle(triangle);
  }
}
