import '../../func/basic.dart';

class BaseRouteModel {
  final int distance;
  final int duration;
  final RouteType routeType;

  BaseRouteModel({
    required this.distance,
    required this.duration,
    required this.routeType,
  });

  // toJson
  Map<String, dynamic> toJson() => {
        'distance': distance,
        'duration': duration,
        'routeType': routeType.toString().split('.').last,
      };
}
