import 'package:nlpf_web_app/api/models/geo_regions.model.dart';

abstract class GeoRegionsState {
  const GeoRegionsState();
}

class InitialGeoRegionsState extends GeoRegionsState {}

class LoadingGeoRegionsState extends GeoRegionsState {}

class SuccessfulGeoRegionsState extends GeoRegionsState {
  final GeoRegionModel result;

  const SuccessfulGeoRegionsState(this.result);
}

class FailedGeoRegionsState extends GeoRegionsState {
  final String error;

  const FailedGeoRegionsState({this.error = 'Unknown error'});
}
