
import 'package:covid_news_app/data/network/constants/endpoints.dart';
import 'package:covid_news_app/data/network/dio_client.dart';
import 'package:covid_news_app/models/country.dart';
import 'package:injectable/injectable.dart';

@injectable
class CountiresApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  CountiresApi(this._dioClient); 

  Future<List<Country>> listAllCountries() async{
    try{
      final res = await _dioClient.get(Endpoints.GET_ALL_COUNTRIES);
      return List<Country>.from(res.map((x) => Country.fromJson(x)));
    }catch(e){
print(e.toString());
      throw e;
    }
  }
}