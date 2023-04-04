import 'dart:convert';
import 'dart:io';

class BaseApiService {
  static const String baseUrl = 'https://routes.googleapis.com/directions/v2';
  static String apiKey = Platform.environment['API_KEY']!;
  static Future<dynamic> get(String url) async {
    final response = await HttpClient().getUrl(Uri.parse(baseUrl + url));
    final responseBody = await response.close();
    return json.decode(await responseBody.transform(utf8.decoder).join());
  }

  Future<dynamic> post(String url, dynamic data, List<String> headers) async {
    final response = await HttpClient().postUrl(Uri.parse(baseUrl + url))
      ..headers.contentType = ContentType.json
      ..headers.set(headers[0], headers[1])
      ..headers.set('X-Goog-Api-Key', apiKey)
      ..write(json.encode(data));
    final responseBody = await response.close();
    return json.decode(await responseBody.transform(utf8.decoder).join());
  }

  static Future<dynamic> put(String url, dynamic data) async {
    final response = await HttpClient().putUrl(Uri.parse(baseUrl + url))
      ..headers.contentType = ContentType.json
      ..write(json.encode(data));
    final responseBody = await response.close();
    return json.decode(await responseBody.transform(utf8.decoder).join());
  }

  static Future<dynamic> delete(String url) async {
    final response = await HttpClient().deleteUrl(Uri.parse(baseUrl + url));
    final responseBody = await response.close();
    return json.decode(await responseBody.transform(utf8.decoder).join());
  }

  static Future<dynamic> patch(String url, dynamic data) async {
    final response = await HttpClient().patchUrl(Uri.parse(baseUrl + url))
      ..headers.contentType = ContentType.json
      ..write(json.encode(data));
    final responseBody = await response.close();
    return json.decode(await responseBody.transform(utf8.decoder).join());
  }

  static Future<dynamic> head(String url) async {
    final response = await HttpClient().headUrl(Uri.parse(baseUrl + url));
    final responseBody = await response.close();
    return json.decode(await responseBody.transform(utf8.decoder).join());
  }

  static Future<dynamic> options(String url) async {
    final response = await HttpClient().getUrl(Uri.parse(baseUrl + url));
    final responseBody = await response.close();
    return json.decode(await responseBody.transform(utf8.decoder).join());
  }

  static Future<dynamic> request(
      String url, String method, dynamic data) async {
    final response =
        await HttpClient().openUrl(method, Uri.parse(baseUrl + url))
          ..headers.contentType = ContentType.json
          ..write(json.encode(data));
    final responseBody = await response.close();
    return json.decode(await responseBody.transform(utf8.decoder).join());
  }
}
