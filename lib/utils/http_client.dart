import 'dart:convert';

import '../routes/medicalRecord/data/Album.dart';
import 'package:http/http.dart' as http;

class HttpClient {

  Future<Album> testClient() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load album');
    }
  }

}