import 'location_model.dart';

class RouteRequestModel {
  RouteRequestModel({
    required this.origin,
    required this.destination,
    required this.travelMode,
    required this.routingPreference,
    required this.requestedReferenceRoutes,
    required this.vehicleInfo,
  });

  factory RouteRequestModel.fromJson(Map<String, dynamic> json) {
    return RouteRequestModel(
        origin: Location.fromJson(json['origin'] as Map<String, dynamic>),
        destination:
            Location.fromJson(json['destination'] as Map<String, dynamic>),
        travelMode: json['travelMode'] as String,
        routingPreference: json['routingPreference'] as String,
        requestedReferenceRoutes:
            json['requestedReferenceRoutes'] as List<dynamic>,
        vehicleInfo: json['vehicleInfo'] as Map<dynamic, dynamic>);
  }

  final Location origin;
  final Location destination;
  final String travelMode;
  final String routingPreference;
  final List<dynamic> requestedReferenceRoutes;
  final Map<dynamic, dynamic> vehicleInfo;

  Map<String, dynamic> toJson() => {
        'origin': origin.toJson(),
        'destination': destination.toJson(),
        'travelMode': travelMode,
        'routingPreference': routingPreference,
        'requestedReferenceRoutes': requestedReferenceRoutes,
        'vehicleInfo': vehicleInfo,
      };
}
