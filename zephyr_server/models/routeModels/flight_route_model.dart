import '../../func/basic.dart';
import 'base_route_model.dart';

class FlightRouteModel extends BaseRouteModel {

  final String? airline;
  final String? flightNumber;
  final String? aircraft;
  final String? departureTerminal;
  final String? arrivalTerminal;
  final String? departureGate;
  final String? arrivalGate;
  final RouteType routeType = RouteType.flight;
  final int? emission;

  FlightRouteModel({
    required int distance,
    required int duration,
    required RouteType routeType,
    this.airline,
    this.flightNumber,
    this.aircraft,
    this.departureTerminal,
    this.arrivalTerminal,
    this.departureGate,
    this.arrivalGate,
    this.emission,
  }) : super(
          distance: distance,
          duration: duration,
          routeType: routeType,
        );


  @override
  Map<String, dynamic> toJson() => {
        'distance': distance,
        'duration': duration,
        'routeType': routeType.toString().split('.').last,
        'airline': airline,
        'flightNumber': flightNumber,
        'aircraft': aircraft,
        'departureTerminal': departureTerminal,
        'arrivalTerminal': arrivalTerminal,
        'departureGate': departureGate,
        'arrivalGate': arrivalGate,
        'emission': emission,
      };
      
  
}