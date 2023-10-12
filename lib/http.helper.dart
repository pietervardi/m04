import 'dart:io';
import 'package:http/http.dart' as http;

class HttpHelper {
  final String _apiKey = "f6f8fc409dd82830067a06388f1da765";
  final String _urlBase = "https://api.themoviedb.org";

  Future<String> getMovie(String category) async {
    var url = Uri.parse("$_urlBase/3/movie/$category?api_key=$_apiKey");
    http.Response result = await http.get(url);
    if (result.statusCode == HttpStatus.ok) {
      String responseBody = result.body;
      return responseBody;
    }
    return result.statusCode.toString();
  }
}
