

import 'package:covid_news_app/data/network/dio_client.dart';
import 'package:injectable/injectable.dart';

@injectable
class NewsApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  NewsApi(this._dioClient); 
  
  }