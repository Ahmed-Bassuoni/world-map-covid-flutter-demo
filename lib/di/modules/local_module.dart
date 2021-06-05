import 'package:covid_news_app/data/network/api/countries_api.dart';
import 'package:covid_news_app/data/network/api/news_api.dart';
import 'package:covid_news_app/data/repository.dart';
import 'package:covid_news_app/data/sharedpref/share_preferences_helper.dart';
import 'package:covid_news_app/di/modules/network_module.dart';
import 'package:injectable/injectable.dart';

@module
abstract class LocalModule extends NetworkModule {
  // DI variables:--------------------------------------------------------------
  // Future<Database> database;

  // constructor
  // Note: Do not change the order in which providers are called, it might cause
  // some issues
  LocalModule() {
    // database = provideDatabase();
  }

  /// A singleton repository provider.
  ///
  /// Calling it multiple times will return the same instance.
  @singleton
  Repository provideRepository(
    NewsApi newsApi,
    SharedPreferenceHelper preferenceHelper,
    CountiresApi countiresApi
  ) =>
      Repository(
        newsApi,
        preferenceHelper,
        countiresApi
      );
}
