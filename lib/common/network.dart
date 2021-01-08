import 'package:http/http.dart' as http;

class ClientNetwork{
  ClientOptions _client = new ClientOptions(new http.Client());
  Future<http.Response> get(String url) {
    // print("requested -> $url");
    return _client.get(url);
  }

  Future<http.Response> post(String url) {
    return _client.post(url);
  }
}

class ClientOptions extends http.BaseClient {
  final http.Client _inner;

  ClientOptions(this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Content-Type'] = 'application/json';
    request.headers['Authorization'] = '563492ad6f91700001000001cd1fd9b36edc40688ee98cd79f657e12';

    return _inner.send(request);
  }
}