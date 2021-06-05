// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

import '../../data/network/api/countries_api.dart' as _i6;
import '../../data/network/api/news_api.dart' as _i4;
import '../../data/network/dio_client.dart' as _i5;
import '../../data/repository.dart' as _i10;
import '../../data/sharedpref/share_preferences_helper.dart' as _i3;
import '../../services/navigation_service.dart' as _i7;
import '../modules/local_module.dart' as _i14;
import '../modules/network_module.dart' as _i13;
import '../modules/preference_module.dart' as _i12;
import '../modules/services_module.dart'
    as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final servicesModule = _$ServicesModule();
  final preferenceModule = _$PreferenceModule();
  final networkModule = _$NetworkModule();
  final localModule = _$LocalModule();
  gh.factory<_i3.SharedPreferenceHelper>(
      () => preferenceModule.provideSharedPreferenceHelper());
  gh.factory<String>(() => networkModule.TAG);
  gh.factory<_i4.NewsApi>(() => _i4.NewsApi(get<_i5.DioClient>()));
  gh.factory<_i6.CountiresApi>(() => _i6.CountiresApi(get<_i5.DioClient>()));
  gh.singleton<_i7.NavigationService>(
      servicesModule.provideNavigationService());
  await gh.singletonAsync<_i8.SharedPreferences>(
      () => preferenceModule.provideSharedPreferences(),
      preResolve: true);
  gh.singleton<_i9.Dio>(
      networkModule.provideDio(get<_i3.SharedPreferenceHelper>()));
  gh.singleton<_i5.DioClient>(networkModule.provideDioClient(get<_i9.Dio>()));
  gh.singleton<_i10.Repository>(localModule.provideRepository(
      get<_i4.NewsApi>(),
      get<_i3.SharedPreferenceHelper>(),
      get<_i6.CountiresApi>()));
  return get;
}

class _$ServicesModule extends _i11.ServicesModule {}

class _$PreferenceModule extends _i12.PreferenceModule {}

class _$NetworkModule extends _i13.NetworkModule {}

class _$LocalModule extends _i14.LocalModule {}
