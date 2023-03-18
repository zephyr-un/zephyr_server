import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

import '../../../../models/route_request_model.dart';
import '../../../../services/routeApiService/route_service.dart';
import 'index.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  final request = context.request;
  final body = await request.body();

  // final jsonBody = jsonDecode(body);
  // // print(jsonBody);
  // final routeRequestModel =
  //     RouteRequestModel.fromJson(jsonBody as Map<String, dynamic>);
  // final routeService = RouteService();
  // final routeModel = await routeService.getRoute(routeRequestModel);
  // final result = routeService.getFuelEfficientRoute(routeModel);
  if (request.method == HttpMethod.post) {
    // final
    // Get request body
    // print(body);
    final jsonBody = jsonDecode(body);

    switch (id) {
      case 'car':
        final routeRequestModel =
            RouteRequestModel.fromJson(jsonBody as Map<String, dynamic>);
        final routeService = RouteService();
        final routeModel = await routeService.getRoute(routeRequestModel);
        final result = routeService.getFuelEfficientRoute(routeModel);

        return Response.json(
          body: result.map(
            (key, value) => MapEntry(
              key,
              value.map((e) => e.toJson()).toList(),
            ),
          ),
        );
      case 'fuel':
        return Response.json(body: {'status': 'API is running'});
      default:
        return Response(
          statusCode: 405,
          body: '${request.method} operation is not supported',
        );
    }

    // return Response.json(body: {'status': 'API is running'});
    // return Response.json(
    //     body: result.map((key, value) => MapEntry(key, value.toJson())));
  } else {
    return Response(
      statusCode: 405,
      body: '${request.method} operation is not supported',
    );
  }
}
