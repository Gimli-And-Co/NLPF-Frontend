import 'package:nlpf_web_app/api/models/geocoding.model.dart';

abstract class IApiRepository {
  Future<GeocodingModel> performGeocoding(
    double latitude,
    double longitude,
  );
}
