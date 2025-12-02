import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieService {
  final String apiKey = "8cad052b"; // Tumhari API key

  Future<List> searchMovies(String query) async {
    final url = "http://www.omdbapi.com/?s=$query&apikey=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['Response'] == "True") {
        return data['Search'];
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to fetch movies');
    }
  }
}
