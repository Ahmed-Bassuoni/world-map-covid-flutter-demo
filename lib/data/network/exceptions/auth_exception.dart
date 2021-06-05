import 'package:covid_news_app/data/network/exceptions/network_exception.dart';

class AuthException extends NetworkException {
  AuthException({message, statusCode})
      : super(message: message, statusCode: statusCode);
}
