// To parse this JSON data, do
//
//     final geoRegionModel = geoRegionModelFromJson(jsonString);

import 'dart:convert';

GeoRegionModel geoRegionModelFromJson(String str) =>
    GeoRegionModel.fromJson(json.decode(str));

String geoRegionModelToJson(GeoRegionModel data) => json.encode(data.toJson());

class GeoRegionModel {
  GeoRegionModel({
    this.type,
    this.features,
  });

  String type;
  List<Feature> features;

  factory GeoRegionModel.fromJson(Map<String, dynamic> json) => GeoRegionModel(
        type: json["type"] == null ? null : json["type"],
        features: json["features"] == null
            ? null
            : List<Feature>.from(
                json["features"].map((x) => Feature.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "features": features == null
            ? null
            : List<dynamic>.from(features.map((x) => x.toJson())),
      };
}

class Feature {
  Feature({
    this.type,
    this.geometry,
    this.properties,
  });

  FeatureType type;
  Geometry geometry;
  Properties properties;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        type: json["type"] == null ? null : featureTypeValues.map[json["type"]],
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        properties: json["properties"] == null
            ? null
            : Properties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : featureTypeValues.reverse[type],
        "geometry": geometry == null ? null : geometry.toJson(),
        "properties": properties == null ? null : properties.toJson(),
      };
}

class Geometry {
  Geometry({
    this.type,
    this.coordinates,
  });

  GeometryType type;
  List<List<List<dynamic>>> coordinates;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type:
            json["type"] == null ? null : geometryTypeValues.map[json["type"]],
        coordinates: json["coordinates"] == null
            ? null
            : List<List<List<dynamic>>>.from(json["coordinates"].map((x) =>
                List<List<dynamic>>.from(
                    x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : geometryTypeValues.reverse[type],
        "coordinates": coordinates == null
            ? null
            : List<dynamic>.from(coordinates.map((x) => List<dynamic>.from(
                x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
      };
}

enum GeometryType { POLYGON, MULTI_POLYGON }

final geometryTypeValues = EnumValues({
  "MultiPolygon": GeometryType.MULTI_POLYGON,
  "Polygon": GeometryType.POLYGON
});

class Properties {
  Properties({
    this.code,
    this.nom,
  });

  String code;
  String nom;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        code: json["code"] == null ? null : json["code"],
        nom: json["nom"] == null ? null : json["nom"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "nom": nom == null ? null : nom,
      };
}

enum FeatureType { FEATURE }

final featureTypeValues = EnumValues({"Feature": FeatureType.FEATURE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
