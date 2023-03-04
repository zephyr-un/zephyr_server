// Route Model

import '../func/basic.dart';

class RouteModel {
  RouteModel({
    required this.distance,
    required this.duration,
    required this.fuelType,
    required this.fuelConsumptionMicroliters,
    required this.routeLabels,
    this.savedConsumption,
    this.savedEmmissions,
  });
  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
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
  // void setSavedConsumption(int savedConsumption) {
  //   this.savedConsumption = savedConsumption;
  // }

  // toJson
  Map<String, dynamic> toJson() => {
        'distance': distance,
        'duration': duration,
        'fuelConsumptionMicroliters': fuelConsumptionMicroliters,
        'routeLabels': routeLabels,
        'savedConsumption': savedConsumption,
        'savedEmmissions': savedEmmissions,
        'fuelType': fuelType.toString().split('.').last,
      };

  final int distance;
  final int duration;
  final int fuelConsumptionMicroliters;
  final List<dynamic> routeLabels;
  final FuelType fuelType;
  int? savedConsumption;
  int? savedEmmissions;
}
