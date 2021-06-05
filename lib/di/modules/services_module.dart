import 'package:covid_news_app/services/navigation_service.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ServicesModule {
  // DI variables:--------------------------------------------------------------

  // DI Providers:--------------------------------------------------------------

  /// A singleton navigation service provider.
  ///
  /// Calling it multiple times will return the same instance.
  @singleton
  NavigationService provideNavigationService() => NavigationService();

}
