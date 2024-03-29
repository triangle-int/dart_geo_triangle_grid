A package for creating a triangle grid on a map. The grid is created by dividing the map into icosphere with 20 triangles and each triangle is divided into 4 smaller triangles and so on.

## Features

- Create triangle from location (latitude, longitude)
- Create location from triangle
- Get center of triangle
- Get triangles of specified depth in bounds

## Getting started

Install the package by adding the following to your `pubspec.yaml`:

```yaml
geo_triangle_grid: ^1.1.1
```

Import the package in your code:

```dart
import 'package:geo_triangle_grid/geo_triangle_grid.dart';
```

## Usage

Here is a simple example of usage:

```dart
final location = LatLng(51.507351, -0.127758);
final triangleHash = TriangleGrid.latLngToHash(location);
print(triangleHash);
// prints: F203320022
final triangle = TriangleGrid.hashToLatLngTriangle(triangleHash);
print(triangle);
// prints: LatLng(latitude: 51.507351,  longitude: -0.127758)
```

### `TriangleGrid.latLngToHash`

Converts a location to a triangle hash. The second parameter is optional and it is the length of the triangle grid.
If not provided, the default value is 20.

```dart
String TriangleGrid.latLngToHash(LatLng location, [ int depth = 20 ]);
```

### `TriangleGrid.hashToLatLngTriangle`

Converts a triangle hash to a triangle with points.

```dart
LatLngTriangle TriangleGrid.latLngToHash(String hash);
```

### `TriangleGrid.hashToLatLng`

Converts a triangle hash to a location.

```dart
LatLng TriangleGrid.hashToLatLng(String hash);
```

### `LatLngTriangle.center`

Gets the center of the triangle.

```dart
LatLng get LatLngTriangle.center;
```

### Aditional methods

Package also provides some additional methods to work with vectors and triangles. All of them have documentation, you can find them in the [API Reference](https://pub.dev/documentation/geo_triangle_grid/latest/geo_triangle_grid/geo_triangle_grid-library.html).
