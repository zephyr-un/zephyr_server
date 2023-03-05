import 'base_route_model.dart';
import 'bicyling_route_model.dart';
import 'flight_route_model.dart';
import 'transit_route_model.dart';
import 'vechile_route_model.dart';
import 'walking_route_model.dart';

/// Class with contain model for generic routes, it could be [VechileRouteModel] or [WalkingRouteModel] or [BicyclingRouteModel] or [TransitRouteModel] or [FlightRouteModel]
///
/// [VechileRouteModel] is a model for route with vehicle
/// [WalkingRouteModel] is a model for route with walking
/// [BicyclingRouteModel] is a model for route with bicycling
/// [TransitRouteModel] is a model for route with transit
/// [FlightRouteModel] is a model for route with flying

class GenericRoutesModel {
  // Perfered Route
  BaseRouteModel? perferedRoute;
  Map<String, BaseRouteModel> routes = {};
  


  GenericRoutesModel({
    this.perferedRoute,
  });
}
