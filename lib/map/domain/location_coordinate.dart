import 'package:shared_preferences/shared_preferences.dart';
import 'package:rol_match/map/data/services/location_search.dart';

class LocationCoordinate {
  final SharedPreferences? sharedPreferences;
  LocationCoordinate({this.sharedPreferences});
  Future<void> saveCoordinate(String location) async {
    LocationSearch locationSearch = new LocationSearch();
    locationSearch.location(location);
  }

  Future<double> getLatitude() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    double? longitud = prefs.getDouble("latitud");
    if (longitud != null) {
      return longitud;
    }
    return 0;
  }

  Future<double> getLongitude() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    double? longitud = prefs.getDouble("longitud");
    if (longitud != null) {
      return longitud;
    }
    return 0;
  }

  Future<void> setCoordinate(double lon, double lat) async {
    final prefs = sharedPreferences ?? await SharedPreferences.getInstance();

    prefs.setDouble("longitud", lon);
    prefs.setDouble("latitud", lat);
  }
}
