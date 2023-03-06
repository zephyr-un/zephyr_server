import '../../func/basic.dart';
import 'base_route_model.dart';

class BicyclingRouteModel extends BaseRouteModel {
  final String? name;
  final String? surface;
  final RouteType routeType = RouteType.bicycling;
  final String? bicycleType;
  final int? emission;

  BicyclingRouteModel({
    required int distance,
    required int duration,
    required RouteType routeType,
    this.name,
    this.surface,
    this.bicycleType,
    this.emission,
  }) : super(
          distance: distance,
          duration: duration,
          routeType: routeType,
        );

  // toJson
  // Have to override the toJson method because the base class has a toJson method
  @override
  Map<String, dynamic> toJson() => {
        'distance': distance,
        'duration': duration,
        'routeType': routeType.toString().split('.').last,
        'name': name,
        'surface': surface,
        'bicycleType': bicycleType,
        'emission': emission,
      };
}
