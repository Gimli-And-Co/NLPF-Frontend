import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nlpf_web_app/api/repositories/api.repository.dart';

import 'geocoding.event.dart';
import 'geocoding.state.dart';

class GeocodingBloc extends Bloc<GeocodingEvent, GeocodingState> {
  final ApiRepository _repository = ApiRepository.instance;

  GeocodingBloc() : super(InitialGeocodingState());

  @override
  Stream<GeocodingState> mapEventToState(GeocodingEvent event) async* {
    if (event is RequestGeocodingEvent) {
      yield LoadingGeocodingState();
      final result = await _repository.performGeocoding(
        event.latitude,
        event.longitude,
      );

      if (result.placeName.isNotEmpty) {
        yield SuccessfulGeocodingState(result);
      } else {
        yield FailedGeocodingState(error: 'Geocoding has failed');
      }
    } else {
      yield FailedGeocodingState();
    }
  }
}
