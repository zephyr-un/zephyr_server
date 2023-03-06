import '../../func/basic.dart';
import 'base_route_model.dart';

class WalkingRouteModel extends BaseRouteModel {
  WalkingRouteModel({
    required super.distance,
    required super.duration,
  }) : super(
          routeType: RouteType.walking,
        );
  @override
  RouteType get routeType => RouteType.walking;

  @override
  Map<String, dynamic> toJson() => {
        'distance': distance,
        'duration': duration,
        'routeType': routeType.toString().split('.').last,
      };
}
