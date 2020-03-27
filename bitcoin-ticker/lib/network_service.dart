import 'package:http/http.dart' as http;

class NetworkService {
  Future<dynamic> getData(String url) async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
    }
  }
}
