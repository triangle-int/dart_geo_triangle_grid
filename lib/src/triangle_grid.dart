import 'dart:math';

import 'lat_lng.dart';
import 'lat_lng_triangle.dart';
import 'vector_3.dart';
import 'vector_3_triangle.dart';

final _phi = (1 + sqrt(5)) / 2;
final _magnitude = 1 / sqrt(1 + pow(_phi, 2));
final _x = 1 * _magnitude;
final _z = _phi * _magnitude;
const _n = 0.0;
final _icosphereVerts = [
  Vector3(-_x, _n, _z),
  Vector3(_x, _n, _z),
  Vector3(-_x, _n, -_z),
  Vector3(_x, _n, -_z),
  Vector3(_n, _z, _x),
  Vector3(_n, _z, -_x),
  Vector3(_n, -_z, _x),
  Vector3(_n, -_z, -_x),
  Vector3(_z, _x, _n),
  Vector3(-_z, _x, _n),
  Vector3(_z, -_x, _n),
  Vector3(-_z, -_x, _n),
];
final _icosphereTriangles = [
  Vector3Triangle(_icosphereVerts[0], _icosphereVerts[4], _icosphereVerts[1]),
  Vector3Triangle(_icosphereVerts[0], _icosphereVerts[9], _icosphereVerts[4]),
  Vector3Triangle(_icosphereVerts[9], _icosphereVerts[5], _icosphereVerts[4]),
  Vector3Triangle(_icosphereVerts[4], _icosphereVerts[5], _icosphereVerts[8]),
  //
  Vector3Triangle(_icosphereVerts[4], _icosphereVerts[8], _icosphereVerts[1]),
  Vector3Triangle(_icosphereVerts[8], _icosphereVerts[10], _icosphereVerts[1]),
  Vector3Triangle(_icosphereVerts[8], _icosphereVerts[3], _icosphereVerts[10]),
  Vector3Triangle(_icosphereVerts[5], _icosphereVerts[3], _icosphereVerts[8]),
  //
  Vector3Triangle(_icosphereVerts[5], _icosphereVerts[2], _icosphereVerts[3]),
  Vector3Triangle(_icosphereVerts[2], _icosphereVerts[7], _icosphereVerts[3]),
  Vector3Triangle(_icosphereVerts[7], _icosphereVerts[10], _icosphereVerts[3]),
  Vector3Triangle(_icosphereVerts[7], _icosphereVerts[6], _icosphereVerts[10]),
  //
  Vector3Triangle(_icosphereVerts[7], _icosphereVerts[11], _icosphereVerts[6]),
  Vector3Triangle(_icosphereVerts[11], _icosphereVerts[0], _icosphereVerts[6]),
  Vector3Triangle(_icosphereVerts[0], _icosphereVerts[1], _icosphereVerts[6]),
  Vector3Triangle(_icosphereVerts[6], _icosphereVerts[1], _icosphereVerts[10]),
  //
  Vector3Triangle(_icosphereVerts[9], _icosphereVerts[0], _icosphereVerts[11]),
  Vector3Triangle(_icosphereVerts[9], _icosphereVerts[11], _icosphereVerts[2]),
  Vector3Triangle(_icosphereVerts[9], _icosphereVerts[2], _icosphereVerts[5]),
  Vector3Triangle(_icosphereVerts[7], _icosphereVerts[2], _icosphereVerts[11]),
];

/// Main class for the triangle grid operations.
///
/// Use static methods from this class to convert between [LatLng] and triangle hash strings.
abstract class TriangleGrid {
  static int _findContainingTriangle(
      List<Vector3Triangle> triangles, Vector3 vector) {
    return triangles.indexWhere((tri) => tri.contains(vector));
  }

  static String _vectorToHashTriangles(
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

  static String _vectorToHash(Vector3 vector, int depth) {
    final firstIndex = _findContainingTriangle(_icosphereTriangles, vector);
    final next = _icosphereTriangles[firstIndex].subdivide();
    final hashRest = _vectorToHashTriangles(next, vector, depth - 1);
    return String.fromCharCode('A'.codeUnits[0] + firstIndex) + hashRest;
  }

  static Vector3Triangle _hashToTriangle(
      Vector3Triangle triangle, String hash) {
    if (hash.isEmpty) {
      return triangle;
    }

    final next = triangle.subdivide()[int.parse(hash[0])];
    return _hashToTriangle(next, hash.substring(1));
  }

  static Vector3Triangle _hashToTriangleRoot(String hash) {
    final initialIndex = hash.codeUnits[0] - 'A'.codeUnits[0];
    final initial = _icosphereTriangles[initialIndex];
    return _hashToTriangle(initial, hash.substring(1));
  }

  static Vector3 _hashToVector(String hash) {
    final triangle = _hashToTriangleRoot(hash);
    return (triangle.a + triangle.b + triangle.c) / 3;
  }

  /// Converts a [LatLng] to a triangle hash string.
  ///
  /// The [depth] parameter specifies the length of the hash string.
  /// More length means more precision.
  static String latLngToHash(LatLng latLng, [int depth = 20]) {
    return _vectorToHash(Vector3.fromLatLng(latLng), depth);
  }

  /// Converts a triangle hash string to a [LatLng].
  static LatLng hashToLatLng(String hash) {
    return _hashToVector(hash).toLatLng();
  }

  /// Converts a triangle hash string to a [LatLngTriangle].
  static LatLngTriangle hashToLatLngTriangle(String hash) {
    final triangle = _hashToTriangleRoot(hash);
    return LatLngTriangle.fromVector3Triangle(triangle);
  }
}
