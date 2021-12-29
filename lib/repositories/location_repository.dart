
import 'dart:ffi';

import 'package:location/location.dart';

class LocationRepository{

  Future<UserLocationData?> getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      print('service not enabled');
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print('service not enabled final');
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.deniedForever) {
      print('PermissionStatus not granted denied forever');
      return UserLocationData(locationData: null, permissionStatus: PermissionStatus.deniedForever);
    }
    if (_permissionGranted == PermissionStatus.denied) {
      print('PermissionStatus not granted');
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('PermissionStatus not granted denied');
        return UserLocationData(locationData: null, permissionStatus: PermissionStatus.denied);
      }
    }

    _locationData = await location.getLocation();
    return UserLocationData(locationData: _locationData, permissionStatus: PermissionStatus.granted);
  }

}

class UserLocationData{
  final LocationData? locationData;
  final PermissionStatus permissionStatus;

  UserLocationData({required this.locationData,required this.permissionStatus});

}