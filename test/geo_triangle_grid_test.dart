import 'dart:math';

import 'package:geo_triangle_grid/geo_triangle_grid.dart';
import 'package:test/test.dart';

void main() {
  group('Vector3', () {
    test('should multiply vector by 3.5', () {
      final vector = Vector3(1, 2, 3);
      final result = vector * 3.5;
      expect(result, Vector3(3.5, 7, 10.5));
    });

    test('should divide vector by 2.8', () {
      final vector = Vector3(2.8, 5.6, 8.4);
      final result = vector / 2.8;
      expect(result, Vector3(2.8 / 2.8, 5.6 / 2.8, 8.4 / 2.8));
    });

    test('should add vector (1, 2, 3)', () {
      final vector = Vector3(3, 2, 1);
      final result = vector + Vector3(1, 2, 3);
      expect(result, Vector3(4, 4, 4));
    });

    test('should subtract vector (1, 2, 3)', () {
      final vector = Vector3(3, 2, 1);
      final result = vector - Vector3(1, 2, 3);
      expect(result, Vector3(2, 0, -2));
    });

    test('should calculate dot product', () {
      final vector = Vector3(1, 2, 3);
      final result = vector.dot(Vector3(4, 5, 6));
      expect(result, 32);
    });

    test('should calculate cross product', () {
      final vector = Vector3(1, 2, 3);
      final result = vector.cross(Vector3(4, 5, 6));
      expect(result, Vector3(-3, 6, -3));
    });

    test('should calculate squared length of vector', () {
      final vector = Vector3(3, 4, 0);
      final lengthSquared = vector.lengthSquared;
      expect(lengthSquared, 25);
    });

    test('should calculate length of vector', () {
      final vector = Vector3(3, 4, 0);
      final length = vector.length;
      expect(length, 5);
    });

    test('should normalize vector', () {
      final vector = Vector3(3, 4, 0);
      final normalized = vector.normalize();
      expect(normalized, Vector3(0.6, 0.8, 0));
    });

    test('should check equality of vectors', () {
      final vector1 = Vector3(1, 2, 3);
      final vector2 = Vector3(1, 2, 3);
      final vector3 = Vector3(4, 5, 6);
      expect(vector1 == vector2, true);
      expect(vector1 == vector3, false);
    });

    test('should convert to string', () {
      final vector = Vector3(1, 2, 3);
      expect(vector.toString(), 'Vector3(x: 1.0, y: 2.0, z: 3.0)');
    });
  });

  group('LatLng', () {
    test('should check equality of LatLng', () {
      final latLng1 = LatLng(1, 2);
      final latLng2 = LatLng(1, 2);
      final latLng3 = LatLng(3, 4);
      expect(latLng1 == latLng2, true);
      expect(latLng1 == latLng3, false);
    });

    test('should convert to string', () {
      final latLng = LatLng(1, 2);
      expect(latLng.toString(), 'LatLng(latitude: 1.0, longitude: 2.0)');
    });
  });

  group('Vector3Triangle', () {
    test('should check equality of Vector3Triangle', () {
      final triangle1 = Vector3Triangle(
        Vector3(1, 2, 3),
        Vector3(4, 5, 6),
        Vector3(7, 8, 9),
      );
      final triangle2 = Vector3Triangle(
        Vector3(1, 2, 3),
        Vector3(4, 5, 6),
        Vector3(7, 8, 9),
      );
      final triangle3 = Vector3Triangle(
        Vector3(10, 11, 12),
        Vector3(13, 14, 15),
        Vector3(16, 17, 18),
      );
      expect(triangle1 == triangle2, true);
      expect(triangle1 == triangle3, false);
    });

    test('should convert to string', () {
      final triangle = Vector3Triangle(
        Vector3(1, 2, 3),
        Vector3(4, 5, 6),
        Vector3(7, 8, 9),
      );
      expect(
        triangle.toString(),
        'Vector3Triangle(a: Vector3(x: 1.0, y: 2.0, z: 3.0), b: Vector3(x: 4.0, y: 5.0, z: 6.0), c: Vector3(x: 7.0, y: 8.0, z: 9.0))',
      );
    });

    test('should subdivide on four triangles', () {
      final triangle = Vector3Triangle(
        Vector3(1, 0, 0),
        Vector3(0, 1, 0),
        Vector3(0, 0, 1),
      );
      final result = triangle.subdivide();
      expect(result.length, 4);
      expect(
          result[0],
          Vector3Triangle(
            Vector3(1, 0, 0),
            Vector3(1 / sqrt2, 1 / sqrt2, 0),
            Vector3(1 / sqrt2, 0, 1 / sqrt2),
          ));
      expect(
          result[1],
          Vector3Triangle(
            Vector3(0, 1, 0),
            Vector3(0, 1 / sqrt2, 1 / sqrt2),
            Vector3(1 / sqrt2, 1 / sqrt2, 0),
          ));
      expect(
          result[2],
          Vector3Triangle(
            Vector3(0, 0, 1),
            Vector3(1 / sqrt2, 0, 1 / sqrt2),
            Vector3(0, 1 / sqrt2, 1 / sqrt2),
          ));
      expect(
          result[3],
          Vector3Triangle(
            Vector3(1 / sqrt2, 1 / sqrt2, 0),
            Vector3(0, 1 / sqrt2, 1 / sqrt2),
            Vector3(1 / sqrt2, 0, 1 / sqrt2),
          ));
    });
  });

  group('LatLngTriangle', () {
    test('should check equality of LatLngTriangle', () {
      final triangle1 = LatLngTriangle(
        LatLng(1, 2),
        LatLng(3, 4),
        LatLng(5, 6),
      );
      final triangle2 = LatLngTriangle(
        LatLng(1, 2),
        LatLng(3, 4),
        LatLng(5, 6),
      );
      final triangle3 = LatLngTriangle(
        LatLng(7, 8),
        LatLng(9, 10),
        LatLng(11, 12),
      );
      expect(triangle1 == triangle2, true);
      expect(triangle1 == triangle3, false);
    });

    test('should convert to string', () {
      final triangle = LatLngTriangle(
        LatLng(1, 2),
        LatLng(3, 4),
        LatLng(5, 6),
      );
      expect(triangle.toString(),
          'LatLngTriangle(a: LatLng(latitude: 1.0, longitude: 2.0), b: LatLng(latitude: 3.0, longitude: 4.0), c: LatLng(latitude: 5.0, longitude: 6.0))');
    });

    test('should calculate center of triangle', () {
      final triangle = LatLngTriangle(
        LatLng(0, 0),
        LatLng(0, 1),
        LatLng(1, 0),
      );
      final center = triangle.center;
      expect(center, LatLng(1 / 3, 1 / 3));
    });
  });

  group('TriangleGird', () {
    test('should create hash for location 1', () {
      // arrange
      final location = LatLng(51.507351, -0.127758);
      // act
      final hash = TriangleGrid.latLngToHash(location, 10);
      // assert
      expect(hash, 'F203320022');
    });

    test('should create hash for location 2', () {
      // arrange
      final location = LatLng(-55.664655876693665, -142.24247207544718);
      // act
      final hash = TriangleGrid.latLngToHash(location, 20);
      // assert
      expect(hash, 'T121313111');
    });

    test('should create hash for vector', () {
      // arrange
      final vector = Vector3(
          -0.44593164572355093, -0.3453708955706184, -0.8257505142808175);
      // act
      final hash = TriangleGrid.vectorToHash(vector, 20);
      // assert
      expect(hash, 'T121313111');
    });

    test('should create location for hash', () {
      // arrange
      final hash = 'F203320022';
      // act
      final location = TriangleGrid.hashToLatLngTriangle(hash).center;
      // assert
      expect(location, LatLng(51.47966748982731, -0.11693856684358583));
    });
  });
}
