import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class TranslateNetwork{
  ClientOptions _client = new ClientOptions(new http.Client());

  Future<http.Response> post(String text, String from, String to) {
    return _client.post(_getUrlTranslate(), body: _getBodyRaw(text, from, to));
  }

  String _getUrlTranslate() {
    return "https://api.us-east.language-translator.watson.cloud.ibm.com/instances/3058864d-8fa7-4c94-9363-47dde4251447/v3/translate?version=2018-05-01";
  }

  String _getBodyRaw(String text, String from, String to){
    String rawBody = "{\"text\"\: \"%text\", \"model_id\":\"%from-%to\"}";
    return rawBody.replaceFirst("%text", text).replaceFirst("%from", from).replaceFirst("%to", to);
  }
}


class ClientOptions extends http.BaseClient {
  final http.Client _inner;

  ClientOptions(this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    String username = 'apikey';
    String password = '_bqjyHj6J6qL6XRC1gYA-2GpZQXMIb0w7bVK_erGDuMc';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    request.headers[HttpHeaders.contentTypeHeader] = 'application/json';
    request.headers[HttpHeaders.authorizationHeader] = basicAuth;
    return _inner.send(request);
  }
}