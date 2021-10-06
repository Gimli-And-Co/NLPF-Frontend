abstract class GeoRegionsEvent {
  const GeoRegionsEvent();
}

class RequestGeoRegionsEvent extends GeoRegionsEvent {
  final double latitude;
  final double longitude;

  const RequestGeoRegionsEvent({
    this.latitude = 0.0,
    this.longitude = 0.0,
  });
}
