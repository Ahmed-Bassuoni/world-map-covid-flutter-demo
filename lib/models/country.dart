class Country {
  String name;
  String alpha2Code;
  String alpha3Code;
  String flag;
  List<double> latlng;

  Country({
    required this.name,
    required this.alpha2Code,
    required this.alpha3Code,
    required this.flag,
    required this.latlng,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json["name"],
        alpha2Code: json["alpha2Code"],
        alpha3Code: json["alpha3Code"],
        flag: json["flag"],
        latlng: List<double>.from(json["latlng"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "alpha2Code": alpha2Code,
        "alpha3Code": alpha3Code,
        "flag": flag,
        "latlng": List<dynamic>.from(latlng.map((x) => x)),
      };
}
