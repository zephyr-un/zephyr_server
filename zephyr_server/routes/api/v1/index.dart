import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

import '../../../models/route_request_model.dart';
import '../../../services/routeApiService/route_service.dart';

Future<Response> onRequest(RequestContext context) async {
  // final
  // Get request body
  final request = context.request;
  final body = await request.body();
  final jsonBody = jsonDecode(body);
  // print(jsonBody);
  final routeRequestModel =
      RouteRequestModel.fromJson(jsonBody as Map<String, dynamic>);
  final routeService = RouteService();
  final routeModel = await routeService.getRoute(routeRequestModel);
  final result = await routeService.getFuelEfficientRoute(routeModel);

  return Response.json(
      body: result.map((key, value) => MapEntry(key, value.toJson())));
}
