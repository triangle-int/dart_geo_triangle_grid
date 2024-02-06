import 'package:geo_triangle_grid/geo_triangle_grid.dart';

void main() {
  latLngToHash();
  latLngToHashWithDepth();
  hashToLatLng();
}

void latLngToHash() {
  // Converting location into a triangle hash string
  final location = LatLng(37.7749, -122.4194);
  final hash = TriangleGrid.latLngToHash(location);
  print(hash);
}

void latLngToHashWithDepth() {
  // Converting location into a triangle hash string with a specific depth
  final location = LatLng(37.7749, -122.4194);
  final hash = TriangleGrid.latLngToHash(location, 12);
  print(hash);
}

void hashToLatLng() {
  // Converting triangle hash string into a location
  final hash = 'G110302102';
  final location = TriangleGrid.hashToLatLng(hash);
  print(location);
}
