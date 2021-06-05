import 'package:covid_news_app/data/network/constants/apis_keys.dart';
import 'package:covid_news_app/data/network/constants/endpoints.dart';
import 'package:covid_news_app/data/network/dio_client.dart';
import 'package:covid_news_app/data/sharedpref/share_preferences_helper.dart';
import 'package:covid_news_app/di/modules/preference_module.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule extends PreferenceModule {
  // ignore: non_constant_identifier_names
  final String TAG = "NetworkModule";

  // DI Providers:--------------------------------------------------------------
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  @singleton
  Dio provideDio(SharedPreferenceHelper sharedPrefHelper) {
    final dio = Dio();

    dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.headers = {
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json',
      }
      ..interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ))
      ..interceptors.add(
        InterceptorsWrapper(onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          // Handle Auth Tokens here.
          if (options.baseUrl.contains(Endpoints.NEWS_API)) {
            options.queryParameters
                .addAll({"apiKey": APIKeys.NEWS_API_KEY, "category": "health"});
          }
          handler.next(options);
        }, onError:
            (DioError error, ErrorInterceptorHandler errorHandler) async {
          print("## on Error ${error.type} ##");
          print("## $error ");
          if (error.response != null && error.response?.statusCode == 401) {
            // UnAutherized
          }
          if (error.type == DioErrorType.connectTimeout ||
              error.message.contains("Connection failed")) {
            // Connection error

          }
          if (error.type == DioErrorType.other) {
            // DioErrorType.DEFAULT
            if (error.toString().contains('SocketException')) {
              // Connection error
            }
          }
          errorHandler.next(error);
        }),
      );

    return dio;
  }

  /// A singleton dio_client provider.
  ///
  /// Calling it multiple times will return the same instance.
  @singleton
  DioClient provideDioClient(Dio dio) => DioClient(dio);
}
