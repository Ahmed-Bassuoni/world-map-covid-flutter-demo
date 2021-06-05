import 'package:covid_news_app/data/network/api/countries_api.dart';
import 'package:covid_news_app/data/network/api/news_api.dart';
import 'package:covid_news_app/data/sharedpref/share_preferences_helper.dart';
import 'package:covid_news_app/models/country.dart';

class Repository {
  // api objects
  final NewsApi _newsApi;
  final CountiresApi _countriesApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  Repository(
    this._newsApi,
    this._sharedPrefsHelper,
    this._countriesApi
  );

  Future<List<Country>> getAllCountries() async {
    return await _countriesApi.listAllCountries();
  }

}
