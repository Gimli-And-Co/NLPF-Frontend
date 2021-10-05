import 'package:nlpf_web_app/api/models/geo_regions.model.dart';
import 'package:nlpf_web_app/api/providers/api.provider.dart';
import 'package:nlpf_web_app/api/repositories/iapi.repository.dart';

import '../../utils/helpers/config.helper.dart';

class ApiGeoRegionsRepository {
  static final ApiGeoRegionsRepository instance = ApiGeoRegionsRepository._();
  final ApiProvider _provider =
      ApiProvider(baseURL: 'https://france-geojson.gregoiredavid.fr/repo/');
  ApiGeoRegionsRepository._();

  @override
  Future<GeoRegionModel> fetchGeoRegions() async {
    final result = await _provider.makeGetRequest(
      'regions.geojson',
    );
    return result != null ? GeoRegionModel.fromJson(result) : GeoRegionModel();
  }
}
