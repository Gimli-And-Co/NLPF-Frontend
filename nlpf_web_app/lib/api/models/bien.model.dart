import 'package:mapbox_gl/mapbox_gl.dart';

class BienModel {
  LatLng coordinates;
  String placeName;

  BienModel({this.coordinates, this.placeName = ''});

  BienModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> queryResult = json['query'];
    this.coordinates = LatLng(
      queryResult[0],
      queryResult[1],
    );
    this.placeName = json['features'][0]['place_name'];
  }

  @override
  String toString() => '$runtimeType: ${coordinates.toJson()}, $placeName';
}
