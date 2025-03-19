import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService{
  final String baseUrl = "https://66f4062c77b5e8897097ef61.mockapi.io/candidate";

  Future<List<Map<String, dynamic>>> getUsers() async {
    final responce = await http.get(Uri.parse(baseUrl));
    return List<Map<String, dynamic>>.from(json.decode(responce.body));
  }

  Future<void> createUser(Map<String, dynamic> user) async {
    await http.post(Uri.parse(baseUrl), headers: {'Content-Type': 'application/json'}, body: json.encode(user));
  }

  Future<void> updateUser(int id, Map<String, dynamic> user) async {
    await http.put(Uri.parse("$baseUrl/$id"), headers: {'Content-Type': 'application/json'}, body: json.encode(user));
  }

  Future<void> deleteUser(int id) async {
    await http.delete(Uri.parse("$baseUrl/$id"));
  }
}