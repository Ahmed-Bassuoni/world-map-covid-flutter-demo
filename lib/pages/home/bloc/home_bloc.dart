import 'dart:convert';

import 'package:covid_news_app/data/repository.dart';
import 'package:covid_news_app/di/components/app_component.dart';
import 'package:covid_news_app/models/country.dart';
import 'package:covid_news_app/models/geo_country.dart';
import 'package:covid_news_app/pages/home/bloc/home_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeLoading());
  Repository _repository = AppComponent.getRepository();
  List<Country> countries = [];
  List<GeoCountry> geoCountries = [];

  Future<void> loadPage() async {
    await loadJsonData();
    countries = await _repository.getAllCountries();
    emit(HomeReady());
  }

  Future<void> loadJsonData() async {
    var jsonText =
        await rootBundle.loadString('lib/assets/countries.geojson.json');
    var decodedJson = json.decode(jsonText)["features"];
    geoCountries =
        List.from(decodedJson.map((ele) => GeoCountry.fromJson(ele)));
  }
}
