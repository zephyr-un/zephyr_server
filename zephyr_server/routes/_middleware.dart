import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  print('middleware');  
  return handler.use(requestLogger());
}
