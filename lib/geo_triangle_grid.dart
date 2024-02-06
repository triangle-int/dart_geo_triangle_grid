/// A library for creating a grid of triangles on the surface of the earth.
///
/// The library provides a way to subdivide the surface of the earth into triangles,
/// which can be defined by hash strings, and then converted to latitude and longitude.
library;

export 'src/lat_lng.dart' show LatLng;
export 'src/lat_lng_triangle.dart' show LatLngTriangle;
export 'src/vector_3.dart' show Vector3;
export 'src/vector_3_triangle.dart' show Vector3Triangle;
export 'src/triangle_grid.dart' show TriangleGrid;
