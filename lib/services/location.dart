import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class Location {
  late double latitude;
  late double longitude;

  Future<Position> getLocation() async {
    if (await Permission.location.request().isGranted) {
      return await Geolocator.getCurrentPosition();
    } else {
      return Future.error('Location permissions denied');
    }
  }

  getCurrentLocation() async {
    Position position = await getLocation();
    latitude = position.latitude;
    longitude = position.longitude;
  }
}
