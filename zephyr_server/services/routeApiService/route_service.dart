import '../../func/basic.dart';
import '../../models/routeModels/vechile_route_model.dart';
import '../../models/route_request_model.dart';
import '../base_api_service.dart';

class RouteService extends BaseApiService {
  // Basic Functions
  final basifunc = BasicFunc();

  // Field Mask
  Map<String, String> fieldMask = {
    'distance': 'routes.distanceMeters',
    'duration': 'routes.duration',
    'routeLabels': 'routes.routeLabels',
    'fuelConsumptionMicroliters':
        'routes.travelAdvisory.fuelConsumptionMicroliters',
    'routeToken': 'routes.routeToken',
  };

  /// Get Route
  ///   - [routeRequestModel] Route Request Model
  ///  - [fieldMask] Field Mask
  /// - [return] Route Model
  /// Description:
  ///  - Get Route from Route Request Model
  Future<List<VechileRouteModel>> getRoute(
      RouteRequestModel routeRequestModel) async {
    final origin = routeRequestModel.origin.toJson();
    final destination = routeRequestModel.destination.toJson();
    origin.remove('name');
    destination.remove('name');
    final data = {
      'origin': {
        'location': {'latLng': origin}
      },
      'destination': {
        'location': {
          'latLng': destination,
        }
      },
      'routeModifiers': {
        'vehicleInfo': routeRequestModel.vehicleInfo,
      },
      'travelMode': routeRequestModel.travelMode,
      'routingPreference': routeRequestModel.routingPreference,
      'requestedReferenceRoutes': routeRequestModel.requestedReferenceRoutes,
    };
    final response = await post(':computeRoutes', data,
        ['X-Goog-FieldMask', fieldMask.values.join(',')]);

    // Add Fuel Type to Route Model
    for (var i = 0; i < (response['routes'] as List).length; i++) {
      response['routes'][i]['fuelType'] =
          routeRequestModel.vehicleInfo['emissionType'];
    }
    return (response['routes'] as List)
        .map((e) => VechileRouteModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Get ["FUEL_EFFICIENT"] route from List<VechileRouteModel>
  ///  - [routes] List<VechileRouteModel>
  /// - [return] Map<String, VechileRouteModel>
  /// Description:
  /// - Get ["FUEL_EFFICIENT"] route from List<VechileRouteModel>
  Map<String, VechileRouteModel> getFuelEfficientRoute(
      List<VechileRouteModel> routes) {
    final fuel = routes.firstWhere((element) {
      if (element.routeLabels.contains('FUEL_EFFICIENT')) {
        return true;
      }
      return false;
    });

    final defaultRoute = routes.firstWhere((element) {
      if (element.routeLabels.contains('DEFAULT_ROUTE')) {
        return true;
      }
      return false;
    });

    final savedFuel = (defaultRoute.fuelConsumptionMicroliters) -
        (fuel.fuelConsumptionMicroliters).abs();

    fuel
      ..savedConsumption = savedFuel
      ..savedEmmissions =
          basifunc.calculateEmissionsSaved(routes[0].fuelType, savedFuel);
    return {'fuelEfficientRoute': fuel, 'defaultRoute': defaultRoute};
  }

  /// Get Recommended Route
}
