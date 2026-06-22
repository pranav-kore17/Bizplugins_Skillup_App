
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'prefernces.dart';
import '../app_manager.dart';
abstract class BaseApiManager {
  Future<dynamic> postApi(String url, dynamic request);
  Future<dynamic> getApi(String url);
  Future<dynamic> postMultipart(String url, String filePath,  Map<String, String> body);
}

class ApiManager extends BaseApiManager {
  @override
  Future getApi(String url) async {
    dynamic responseJson = {};
    bool isInternetConnected = await AppManager().isConnectedToInternet();
    if(!isInternetConnected) {
      AppManager.showToast("Unable to connect. Please check your internet connection and try again");
      return responseJson;
    }
    try {
      http.Response response = await http.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
      ).timeout(const Duration(seconds: 10));
      responseJson = jsonDecode(response.body);
    } catch (e){
      print(e.toString());
    }
    return responseJson;

  }

  @override
  Future postApi(String url, request) async {
    dynamic responseJson = {};
    bool isInternetConnected = await AppManager().isConnectedToInternet();
    if(!isInternetConnected) {
      AppManager.showToast("Unable to connect. Please check your internet connection and try again");
      return responseJson;
    }
    String token = await Preferences.getAccessToken();
    var headers =  {
      "Content-Type": "application/json",
      "Authorization":  "Bearer $token"
    };
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: headers,
          body: jsonEncode(request)
      ).timeout(const Duration(seconds: 10));
      responseJson = jsonDecode(response.body);
    } catch (e) {
      print(e);
    }
    final curlCommand = generateCurlCommand(
      method: "POST",
      url: url,
      headers: headers,
      body: request,
    );

    print("Generated cURL:\n$curlCommand");
    return responseJson;
  }

  @override
  Future<dynamic> postMultipart(String url, String filePath,  Map<String, String> body) async {
    dynamic responseJson = {};
    bool isInternetConnected = await AppManager().isConnectedToInternet();
    if(!isInternetConnected) {
      AppManager.showToast("Unable to connect. Please check your internet connection and try again");
      return responseJson;
    }
    String token = await Preferences.getAccessToken();
    print(token);
    Map<String, String> headers = {
      'Accept': 'application/json',
      'authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.headers.addAll(headers);
    request.fields.addAll(body);
    if (filePath.isNotEmpty) {
      var multipartFile = await http.MultipartFile.fromPath("image", filePath);
      request.files.add(multipartFile);
    }

    http.StreamedResponse response = await request.send();
    try {
      final respStr = await response.stream.bytesToString();
      responseJson = jsonDecode(respStr);
    }
    catch (e) {
      return print(e);
    }
    return responseJson;
  }

  String generateCurlCommand({
    required String method,
    required String url,
    Map<String, String>? headers,
    dynamic body,
  }) {
    final curl = StringBuffer();

    curl.write('curl -X ${method.toUpperCase()} "${url.toString()}"');

    // Add headers
    headers?.forEach((key, value) {
      curl.write(' -H "${_escapeQuotes(key)}: ${_escapeQuotes(value)}"');
    });

    // Add body if available
    if (body != null) {
      String encodedBody = body is String ? body : jsonEncode(body);
      curl.write(" -d '${_escapeSingleQuotes(encodedBody)}'");
    }

    return curl.toString();
  }

  String _escapeQuotes(String input) => input.replaceAll('"', '\\"');

  String _escapeSingleQuotes(String input) => input.replaceAll("'", "'\\''");

}
