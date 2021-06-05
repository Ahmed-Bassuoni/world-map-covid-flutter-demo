class GeoCountry {
    GeoCountry({
       required this.type,
       required this.properties,
    });

    String type;
    Properties properties;

    factory GeoCountry.fromJson(Map<String, dynamic> json) => GeoCountry(
        type: json["type"],
        properties: Properties.fromJson(json["properties"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "properties": properties.toJson(),
    };
}

class Geometry {
    Geometry({
      required  this.type,
      required  this.coordinates,
    });

    String type;
    List<List<List<double>>> coordinates;

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates: List<List<List<double>>>.from(json["coordinates"].map((x) => List<List<double>>.from(x.map((x) => List<double>.from(x.map((x) => x.toDouble())))))),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => List<dynamic>.from(x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
    };
}

class Properties {
    Properties({
      required  this.admin,
      required  this.isoA3,
    });

    String admin;
    String isoA3;

    factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        admin: json["ADMIN"],
        isoA3: json["ISO_A3"],
    );

    Map<String, dynamic> toJson() => {
        "ADMIN": admin,
        "ISO_A3": isoA3,
    };
}
