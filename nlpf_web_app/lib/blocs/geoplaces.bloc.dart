import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nlpf_web_app/api/repositories/regions.repository.dart';

import 'geoplaces.event.dart';
import 'geoplaces.state.dart';

class GeoRegionsBloc extends Bloc<GeoRegionsEvent, GeoRegionsState> {
  final ApiGeoRegionsRepository _repository = ApiGeoRegionsRepository.instance;

  GeoRegionsBloc() : super(InitialGeoRegionsState());

  @override
  Stream<GeoRegionsState> mapEventToState(GeoRegionsEvent event) async* {
    if (event is RequestGeoRegionsEvent) {
      yield LoadingGeoRegionsState();
      final result = await _repository.fetchGeoRegions();

      if (result.features.isNotEmpty) {
        yield SuccessfulGeoRegionsState(result);
      } else {
        yield FailedGeoRegionsState(error: 'GeoRegions has failed');
      }
    } else {
      yield FailedGeoRegionsState();
    }
  }
}
