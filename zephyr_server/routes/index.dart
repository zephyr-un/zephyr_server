import 'package:dart_frog/dart_frog.dart';
import 'package:firedart/firedart.dart';





const API_KEY = String.fromEnvironment('API_KEY');

final firebaseAuth = FirebaseAuth.initialize(
  API_KEY,
  VolatileStore(),
);

/// Base of API
/// Run status of API

Response onRequest(RequestContext context) {
  final request = context.request;

  switch (request.method) {
    case HttpMethod.get:
      return Response.json(body: {'status': 'API is running'});
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
      return Response(
        statusCode: 405,
        body: '${request.method} operation is not supported',
      );
    case HttpMethod.delete:
      return Response(
        statusCode: 405,
        body: '${request.method} operation requires a id',
      );
    case HttpMethod.post:
      return Response.json(body: {'status': 'API is running'});
    case HttpMethod.put:
      return Response(
        statusCode: 405,
        body: '${request.method} operation requires a id',
      );
  }
}
