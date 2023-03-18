import '../../func/basic.dart';
import '../../models/routeModels/transit_route_model.dart';
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
    // provideRouteAlternatives
    'fuelConsumptionMicroliters':
        'routes.travelAdvisory.fuelConsumptionMicroliters',
    // 'routeToken': 'routes.routeToken',
    // Polyline
    'polyline': 'routes.polyline',
  };

  /// Get Route
  ///   - [routeRequestModel] Route Request Model
  ///  - [fieldMask] Field Mask
  /// - [return] Route Model
  /// Description:
  ///  - Get Route from Route Request Model
  Future<List<VechileRouteModel>> getRoute(
    RouteRequestModel routeRequestModel,
  ) async {
    final origin = routeRequestModel.origin.toJson();
    final destination = routeRequestModel.destination.toJson();
    origin.remove('name');
    destination.remove('name');

    String kTravelMode() {
      switch (routeRequestModel.travelMode) {
        case RouteType.driving:
          return 'DRIVE';
        case RouteType.bicycling:
          return 'BICYCLE';
        case RouteType.walking:
          return 'WALK';
        case RouteType.transit:
          return 'TRANSIT';
        case RouteType.flight:
          return 'NOT_SUPPORTED';
      }
    }

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
      // Show Route Alternatives
      'computeAlternativeRoutes': true,
      'travelMode': kTravelMode(),

      'routingPreference': routeRequestModel.routingPreference,
      'requestedReferenceRoutes': routeRequestModel.requestedReferenceRoutes,
    };
    final response = await post(
      ':computeRoutes',
      data,
      ['X-Goog-FieldMask', fieldMask.values.join(',')],
    );

    print(response);

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
  Map<String, List<VechileRouteModel>> getFuelEfficientRoute(
    List<VechileRouteModel> routes,
  ) {
    final fuel = routes.firstWhere((element) {
      if (element.routeLabels.contains('FUEL_EFFICIENT')) {
        return true;
      }
      return false;
    });

    final defaultRoute = routes.where((element) {
      if (element.routeLabels.contains('DEFAULT_ROUTE') ||
          element.routeLabels.contains('DEFAULT_ROUTE_ALTERNATE')) {
        return true;
      }
      return false;
    }).toList();

    // Calculate Saved Fuel
    // Pick the minimum duration route and get the fuel consumption and get the
    // difference between the fuel efficient route and minimum duration route
    final idealRoute = defaultRoute.reduce(
      (value, element) => value.duration < element.duration ? value : element,
    );
    final savedFuel =
        idealRoute.fuelConsumptionMicroliters - fuel.fuelConsumptionMicroliters;

    fuel
      ..savedConsumption = savedFuel
      ..savedEmmissions =
          basifunc.calculateEmissionsSaved(routes[0].fuelType, savedFuel);
    for (final element in defaultRoute) {
      element
        ..savedConsumption = idealRoute.fuelConsumptionMicroliters -
            element.fuelConsumptionMicroliters
        ..savedEmmissions = basifunc.calculateEmissionsSaved(
          routes[0].fuelType,
          idealRoute.fuelConsumptionMicroliters -
              element.fuelConsumptionMicroliters,
        );
    }

    return {
      'fuelEfficientRoute': [fuel],
      // Return List of .toMap of defaultRoute
      'otherRoutes': defaultRoute
    };
  }

  /// Get Transit Routes
  ///  - [routes] List<Tra =>
  /// - [return] List<VechileRouteModel>
  /// Description:
  /// - Get Other Routes
  Future<List<TransitRouteModel>> getTransitRoutes(
    RouteRequestModel routeRequestModel,
  ) async {
    return [];
  }
}
