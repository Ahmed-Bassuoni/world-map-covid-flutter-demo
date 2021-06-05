

import 'package:covid_news_app/data/sharedpref/constants/preferences.dart';
import 'package:covid_news_app/utils/string_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final Future<SharedPreferences> _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);


    Future<String?> get authToken {
    return _sharedPreference.then((preference) {
      return preference.getString(Preferences.auth_token);
    });
  }

    Future<void> saveAuthToken(String authToken) {
    return _sharedPreference.then((preference) {
      preference.setString(Preferences.auth_token, authToken);
    });
  }

    Future<void> removeAuthToken() async {
    return _sharedPreference.then((preference) {
      preference.remove(Preferences.auth_token);
    });
  }


    Future<bool> get isLoggedIn async {
    return _sharedPreference.then((preference) async {
      print(preference.getString(Preferences.auth_token));
      var loggedIn = StringUtil.isNotEmptyOrNull(
              preference.getString(Preferences.auth_token) ?? '')
          ? true
          : false;
      return loggedIn;
    });
  }

}