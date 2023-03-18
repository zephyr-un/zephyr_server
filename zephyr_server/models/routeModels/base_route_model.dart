import '../../func/basic.dart';

class BaseRouteModel {
  BaseRouteModel({
    required this.distance,
    required this.duration,
    required this.routeType,
  });
  int distance;
  int duration;
  final RouteType routeType;

  // toJson
  Map<String, dynamic> toJson() => {
        'distance': distance,
        'duration': duration,
        'routeType': routeType.toString().split('.').last,
      };
}
