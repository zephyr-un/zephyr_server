import 'package:dart_frog/dart_frog.dart';
import 'package:firedart/firedart.dart';

import '../func/req.dart';

const API_KEY = 'AIzaSyBlFXfZNXaX_9I_Rls8ExqxkTu6OI1X3e0';

final firebaseAuth = FirebaseAuth.initialize(
  API_KEY,
  VolatileStore(),
);

/// Base of API
/// Run status of API

Response onRequest(RequestContext context) {
  req().then((value) => print(value));
  // print(d);

  return Response(body: 'Hello, world! from ${context.request.uri.path}');
}
