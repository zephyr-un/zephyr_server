/*
curl -X POST -d '{
  "origin":{
    "location":{
      "latLng":{
        "latitude": 37.419734,
        "longitude": -122.0827784
      }
    }
  },
  "destination":{
    "location":{
      "latLng":{
        "latitude": 37.417670,
        "longitude": -122.079595
      }
    }
  },
  "travelMode": "DRIVE",
  "routingPreference": "TRAFFIC_AWARE",
  "departureTime": "2023-10-15T15:01:23.045123456Z",
  "computeAlternativeRoutes": false,
  "routeModifiers": {
    "avoidTolls": false,
    "avoidHighways": false,
    "avoidFerries": false
  },
  "languageCode": "en-US",
  "units": "IMPERIAL"
}' \
-H 'Content-Type: application/json' -H 'X-Goog-Api-Key: YOUR_API_KEY' \
-H 'X-Goog-FieldMask: routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline' \
'https://routes.googleapis.com/directions/v2:computeRoutes'
*/

// Convert to dart http request
// 40.816837227611984, -81.93517557215301
// 40.45208178656696, -79.94390358952884
import 'dart:convert';
import 'dart:io';

import '../models/routeModels/generic_routes.dart';

final data = {
  'origin': {
    'location': {
      'latLng': {
        'latitude': 40.816837227611984,
        'longitude': -81.93517557215301
      }
    }
  },
  'destination': {
    'location': {
      'latLng': {'latitude': 40.45208178656696, 'longitude': -79.94390358952884}
    }
  },
  'routeModifiers': {
    'vehicleInfo': {'emissionType': 'GASOLINE'}
  },
  'travelMode': 'DRIVE',
  'routingPreference': 'TRAFFIC_AWARE_OPTIMAL',
  'requestedReferenceRoutes': ['FUEL_EFFICIENT']
};
Future<dynamic> req() async {
  final response = await HttpClient().postUrl(Uri.parse(
      'https://routes.googleapis.com/directions/v2:computeRoutes?key=AIzaSyBlFXfZNXaX_9I_Rls8ExqxkTu6OI1X3e0'))
    ..headers.contentType = ContentType.json
    ..headers.set('X-Goog-FieldMask',
        'routes.distanceMeters,routes.duration,routes.routeLabels,routes.travelAdvisory.fuelConsumptionMicroliters,routes.routeToken')
    ..write(json.encode(data));
  final responseBody = await response.close();
  final j = json.decode(await responseBody.transform(utf8.decoder).join());


  final defaultRoute = (j['routes'] as List).firstWhere((element) {
    if ((element['routeLabels']! as List).contains('DEFAULT_ROUTE')) {
      print("DEFAULT_ROUTE" + element['travelAdvisory'].toString());
      return true;
    }
    return false;
  });
  // print(defaultRoute);
  final fuelEfficientRoute = (j['routes'] as List).firstWhere((element) {
    if ((element['routeLabels']! as List).contains('FUEL_EFFICIENT')) {
      print("FUEL_EFFICIENT" + element['travelAdvisory'].toString());
      return true;
    }
    return false;
  });

  // final fuelEfficientRoute = j['routes'].firstWhere(
  //     (element) => element['routeLabels'].contains('fuelEfficientRoute'),
  //     orElse: () => null);

  // GenericRoutesModel(perferedRoute: Bic)

  final fuelConsumptionMicroliters = int.parse(defaultRoute['travelAdvisory']
          ['fuelConsumptionMicroliters'] as String) -
      int.parse(fuelEfficientRoute['travelAdvisory']
          ['fuelConsumptionMicroliters'] as String);

  return fuelConsumptionMicroliters;
}
