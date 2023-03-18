// Route Model

import '../../func/basic.dart';
import 'base_route_model.dart';

class VechileRouteModel extends BaseRouteModel {
  VechileRouteModel({
    required this.distance,
    required this.duration,
    required this.fuelType,
    required this.polyline,
    required this.fuelConsumptionMicroliters,
    required this.routeLabels,
    this.savedConsumption,
    this.savedEmmissions,
  }) : super(
          routeType: RouteType.driving,
          distance: distance,
          duration: duration,
        );

  factory VechileRouteModel.fromJson(Map<String, dynamic> json) {
    return VechileRouteModel(
      // ignore: avoid_dynamic_calls
      polyline: json['polyline']['encodedPolyline'] as String,
      distance: json['distanceMeters'] as int,
      duration: int.parse(
        (json['duration'] as String)
            .substring(0, (json['duration'] as String).length - 1),
      ),
      // ignore: avoid_dynamic_calls
      fuelConsumptionMicroliters: int.parse(
        json['travelAdvisory']['fuelConsumptionMicroliters'] as String,
      ),
      routeLabels: json['routeLabels'] as List,
      savedConsumption: 0,
      savedEmmissions: 0,
      fuelType: FuelType.values.firstWhere(
        (e) =>
            e.toString().split('.').last.toUpperCase() ==
            json['fuelType'] as String,
      ),
    );
  }

  // Setters
  void setDistance(int distance) => this.distance = distance;
  Map<String, dynamic> toJson() => {
        'distance': distance,
        'duration': duration,
        'fuelConsumptionMicroliters': fuelConsumptionMicroliters,
        'routeLabels': routeLabels,
        'savedConsumption': savedConsumption,
        'savedEmmissions': savedEmmissions,
        'fuelType': fuelType.toString().split('.').last,
        'polyline': polyline,
      };

  int distance;
  final int duration;
  final int fuelConsumptionMicroliters;
  final List<dynamic> routeLabels;
  final FuelType fuelType;
  final String polyline;
  int? savedConsumption;
  int? savedEmmissions;
}
