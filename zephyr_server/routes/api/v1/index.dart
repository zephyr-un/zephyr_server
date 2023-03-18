import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
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
