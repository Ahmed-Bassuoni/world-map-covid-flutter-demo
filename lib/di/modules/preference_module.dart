import 'package:covid_news_app/data/sharedpref/share_preferences_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class PreferenceModule {
  // DI variables:--------------------------------------------------------------



  // DI Providers:--------------------------------------------------------------
  /// A singleton preference provider.
  ///
  /// Calling it multiple times will return the same instance.
  @singleton
  @preResolve
  Future<SharedPreferences> provideSharedPreferences() {
    return SharedPreferences.getInstance();
  }

  /// A singleton preference helper provider.
  ///
  /// Calling it multiple times will return the same instance.
  @injectable
  SharedPreferenceHelper provideSharedPreferenceHelper() {
    return SharedPreferenceHelper(SharedPreferences.getInstance());
  }
}
