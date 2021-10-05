import 'package:nlpf_web_app/api/models/geocoding.model.dart';

abstract class GeocodingState {
  const GeocodingState();
}

class InitialGeocodingState extends GeocodingState {}

class LoadingGeocodingState extends GeocodingState {}

class SuccessfulGeocodingState extends GeocodingState {
  final GeocodingModel result;

  const SuccessfulGeocodingState(this.result);
}

class FailedGeocodingState extends GeocodingState {
  final String error;

  const FailedGeocodingState({this.error = 'Unknown error'});
}
