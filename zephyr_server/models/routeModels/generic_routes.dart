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
  Map<String, Map<dynamic, dynamic>> routes = {};

  GenericRoutesModel({
    this.perferedRoute,
  });

  /// Add route to [routes] map
  ///
  void addRoute(BaseRouteModel route, dynamic type) {
    // Case for each type of route model
    switch (type) {
      case VechileRouteModel:
        routes[route.routeType.toString()] =
            (type as VechileRouteModel).toJson();
        break;
      case WalkingRouteModel:
        routes[route.routeType.toString()] =
            (type as WalkingRouteModel).toJson();
        break;
      case BicyclingRouteModel:
        routes[route.routeType.toString()] =
            (type as BicyclingRouteModel).toJson();
        break;
      case TransitRouteModel:
        routes[route.routeType.toString()] =
            (type as TransitRouteModel).toJson();
        break;
      case FlightRouteModel:
        routes[route.routeType.toString()] =
            (type as FlightRouteModel).toJson();
        break;
      default:
        routes[route.routeType.toString()] = (type as BaseRouteModel).toJson();
        break;
    }
  }
}
