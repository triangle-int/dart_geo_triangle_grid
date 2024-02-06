class LatLng {
  final double latitude;
  final double longitude;

  LatLng(this.latitude, this.longitude);

  @override
  operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LatLng &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;

  @override
  String toString() {
    return 'LatLng(latitude: $latitude, longitude: $longitude)';
  }
}
