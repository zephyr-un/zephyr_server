import '../../func/basic.dart';
import 'base_route_model.dart';

class TransitRouteModel extends BaseRouteModel {
  final String? name;
  final RouteType routeType = RouteType.transit;

  TransitRouteModel({
    required int distance,
    required int duration,
    required RouteType routeType,
    this.name,
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
      };
}
