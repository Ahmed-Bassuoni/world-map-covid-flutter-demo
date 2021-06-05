

import 'package:covid_news_app/data/repository.dart';
import 'package:covid_news_app/data/sharedpref/share_preferences_helper.dart';
import 'package:covid_news_app/di/components/app_component.config.dart';
import 'package:covid_news_app/services/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;
@injectableInit
Future<GetIt> configureInjection({String env = Env.dev}) async {
  return $initGetIt(getIt, environment: env);
}


/// The top level injector that stitches together multiple app features into
/// a complete app.
abstract class AppComponent {
  /// An accessor to RestClient object that an application may use.
  static Repository getRepository() => getIt<Repository>();

  /// An accessor to Shared Prefrences Helper.
  static SharedPreferenceHelper getSharedPrefrencesHelper() =>
      getIt<SharedPreferenceHelper>();

  /// An accessor to Navigation Service.
  static NavigationService getNavigationService() => getIt<NavigationService>();
}

abstract class Env {
  static const dev = "dev";
  static const prod = "prod";
}