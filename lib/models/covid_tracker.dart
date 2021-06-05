import 'dart:convert';

CovidTracker covidTrackerFromJson(String str) =>
    CovidTracker.fromJson(json.decode(str));

String covidTrackerToJson(CovidTracker data) => json.encode(data.toJson());

class CovidTracker {
  Map<String, TrackerData> dates;
  Metadata? metadata;
  Total? total;

  CovidTracker({
    this.dates = const {},
    this.metadata,
    this.total,
  });

  factory CovidTracker.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> datesJson = json["dates"] ?? {};
    Map<String, TrackerData> datesFromJson = {};
    datesJson.forEach((key, value) {
      datesFromJson.addAll({key: TrackerData.fromJson(value)});
    });
    return CovidTracker(
      dates: datesFromJson,
      metadata: Metadata.fromJson(json["metadata"]),
      total: Total.fromJson(json["total"]),
    );
  }
  Map<String, dynamic> toJson() => {
        "dates": dates,
        "metadata": metadata?.toJson() ?? {},
        "total": total?.toJson() ?? {},
      };
}

class TrackerData {
  final Map<String, Total> countries;
  final TrackerCountryInfo? info;
  TrackerData({
    this.countries = const {},
    this.info,
  });

  factory TrackerData.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> countriesJson = json["countries"] ?? {};
    Map<String, Total> countriesFromJson = {};
    countriesJson.forEach((key, value) {
      countriesFromJson.addAll({key: Total.fromJson(value)});
    });
    return TrackerData(
      countries: countriesFromJson,
      info: TrackerCountryInfo.fromJson(json["info"]),
    );
  }
  Map<String, dynamic> toJson() => {
        "countries": countries,
        "info": info,
      };
}

class TrackerCountryInfo {
  final String date;
  final String dateGeneration;
  final String yesterday;

  TrackerCountryInfo({
    required this.date,
    required this.dateGeneration,
    required this.yesterday,
  });

  factory TrackerCountryInfo.fromJson(Map<String, dynamic> json) =>
      TrackerCountryInfo(
        date: json["date"],
        dateGeneration: json["date_generation"],
        yesterday: json["yesterday"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "date_generation": dateGeneration,
        "yesterday": yesterday,
      };
}

class Metadata {
  final String by;
  final List<String> url;
  Metadata({
    required this.by,
    this.url = const [],
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        by: json["by"],
        url: List<String>.from(json["url"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "by": by,
        "url": List<dynamic>.from(url.map((x) => x)),
      };
}

class Total {
  DateTime date;
  String? id;
  String name;
  String source;
  int todayConfirmed;
  int todayDeaths;
  int todayNewConfirmed;
  int todayNewDeaths;
  int todayNewOpenCases;
  int todayNewRecovered;
  int todayOpenCases;
  int todayRecovered;

  Total({
    required this.date,
    this.id,
    required this.name,
    this.source = "",
    this.todayConfirmed = 0,
    this.todayDeaths = 0,
    this.todayNewConfirmed = 0,
    this.todayNewDeaths = 0,
    this.todayNewOpenCases = 0,
    this.todayNewRecovered = 0,
    this.todayOpenCases = 0,
    this.todayRecovered = 0,
  });

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        date: DateTime.parse(json["date"]),
        id: json["id"] == null ? null : json["id"],
        name: json["name"],
        source: json["source"] == null ? null : json["source"],
        todayConfirmed:
            json["today_confirmed"] == null ? null : json["today_confirmed"],
        todayDeaths: json["today_deaths"] == null ? null : json["today_deaths"],
        todayNewConfirmed: json["today_new_confirmed"] == null
            ? null
            : json["today_new_confirmed"],
        todayNewDeaths:
            json["today_new_deaths"] == null ? null : json["today_new_deaths"],
        todayNewOpenCases: json["today_new_open_cases"] == null
            ? null
            : json["today_new_open_cases"],
        todayNewRecovered: json["today_new_recovered"] == null
            ? null
            : json["today_new_recovered"],
        todayOpenCases:
            json["today_open_cases"] == null ? null : json["today_open_cases"],
        todayRecovered:
            json["today_recovered"] == null ? null : json["today_recovered"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "id": id == null ? null : id,
        "name": name,
        "source": source,
        "today_confirmed": todayConfirmed,
        "today_deaths": todayDeaths,
        "today_new_confirmed": todayNewConfirmed,
        "today_new_deaths": todayNewDeaths,
        "today_new_open_cases": todayNewOpenCases,
        "today_new_recovered": todayNewRecovered,
        "today_open_cases": todayOpenCases,
        "today_recovered": todayRecovered,
      };
}
