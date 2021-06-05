import 'package:covid_news_app/models/country.dart';
import 'package:covid_news_app/pages/home/bloc/home_bloc.dart';
import 'package:covid_news_app/pages/home/bloc/home_state.dart';
import 'package:covid_news_app/utils/svg_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeCubit _homeCubit = HomeCubit();
  final MapShapeLayerController _mapController = MapShapeLayerController();

  @override
  void initState() {
    _homeCubit.loadPage();
    super.initState();
  }

  @override
  void dispose() {
    _homeCubit.close();
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("World Map"),
    );
  }

  Widget _buildBody() {
    return SafeArea(
        child: BlocConsumer(
      bloc: _homeCubit,
      listener: (context, state) {
        print(
            "### markers count: ${_mapController.markersCount}  ${_homeCubit.geoCountries.length}");

        /* for(int i=0; i < _homeCubit.geoCountries.length; i++){
          _mapController.insertMarker(i);
          _mapController.notifyListeners();
        }
        print("#### Added Markers");
        print("### markers count: ${_mapController.markersCount}  ${_homeCubit.geoCountries.length}"); */
      },
      builder: (context, state) => Container(
        child: state is HomeLoading ? _buildLoadingUI() : _buildWorldMap(),
      ),
    ));
  }

  Widget _buildLoadingUI() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  int selectedCountry = -1;
  Widget _buildWorldMap() {
    return Container(
      child: SfMaps(
        key: Key("worldMap"),
        layers: [
          MapShapeLayer(
            controller: _mapController,
            source: MapShapeSource.asset(
              'lib/assets/countries.geojson.json',
              shapeDataField: 'ADMIN',
            ),
            //showDataLabels: true,
            shapeTooltipBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(7),
                child: Text("$index",
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Theme.of(context).colorScheme.surface)),
              );
            },
            tooltipSettings: MapTooltipSettings(
                color: Colors.grey[700],
                strokeColor: Colors.white,
                strokeWidth: 2),
            zoomPanBehavior: MapZoomPanBehavior(
              enableDoubleTapZooming: true,
              enablePanning: true,
              enablePinching: true,
              showToolbar: true,
              zoomLevel: 7,
              focalLatLng: MapLatLng(31.963158, 36.930359),
            ),
            selectionSettings: MapSelectionSettings(
                color: Colors.red, strokeColor: Colors.white, strokeWidth: 1.5),
            selectedIndex: selectedCountry,
            strokeColor: Colors.white,
            strokeWidth: .5,
            color: Colors.blue,
            loadingBuilder: (context) {
              return _buildLoadingUI();
            },
            markerBuilder: (context, index) {
              print("## Countries: ${_homeCubit.countries.length}");
              print("## GeoCountries: ${_homeCubit.geoCountries.length}");
              print(
                  "## marker index: ${index} ${_homeCubit.geoCountries[index].properties.isoA3}");
              Country? country = _homeCubit.countries.cast<Country?>().firstWhere((c) =>
                  c?.alpha3Code ==
                  _homeCubit.geoCountries[index].properties.isoA3, orElse: () => null);
              return country != null ? MapMarker(
                latitude: country.latlng.length > 0 ? country.latlng[0] : 0,
                longitude: country.latlng.length > 1 ? country.latlng[1] :  0,
                iconColor: Colors.yellow,
                iconType: MapIconType.circle,
                child: Container(
                    width: 40,
                    height: 30,
                    child: SVGUtil.renderFromNetwork(country.flag)),
              ): MapMarker(latitude: 0, longitude: 0);
            },
            initialMarkersCount: _homeCubit.geoCountries.length,
            markerTooltipBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(7),
                child: Text("$index",
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Theme.of(context).colorScheme.surface)),
              );
            },
            onSelectionChanged: (index) {
              print("onSelectionChanged");
              setState(() {
                selectedCountry = index;
              });
            },
            dataLabelSettings: MapDataLabelSettings(
              textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.caption!.fontSize),
            ),
          ),
        ],
      ),
    );
  }
}
