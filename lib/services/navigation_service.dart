import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic>? navigateTo(String routeName) {
    print("## navigateTo: $routeName");
    return navigatorKey.currentState?.pushNamed(routeName);
  }

  Future<dynamic>? navigateToWithParams(String routeName, dynamic params) {
    print("## navigateToWithParams: $routeName");
    return navigatorKey.currentState?.pushNamed(routeName, arguments: params);
  }

  Future<dynamic>? replaceAndNavigateTo(String routeName) {
    print("## replaceAndNavigateTo: $routeName");
    return navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  Future<dynamic>? replaceAndRemoveTo(String routeName,
      {required String removeUntil}) {
    return navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(routeName, ModalRoute.withName(removeUntil));
  }

  Future<dynamic>? replaceAndNavigateToWithParams(
      String routeName, dynamic params) {
    print("## replaceAndNavigateToWithParams: $routeName");
    return navigatorKey.currentState
        ?.pushReplacementNamed(routeName, arguments: params);
  }

  Route getCurrentRoute() {
    late Route currentRoute;
    navigatorKey.currentState?.popUntil((route) {
      currentRoute = route;
      // Return true so popUntil() pops nothing.
      return true;
    });
    return currentRoute;
  }

  void goBack<T>({T? args}) {
    return navigatorKey.currentState?.pop<T>(args);
  }
}
