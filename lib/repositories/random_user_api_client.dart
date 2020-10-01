import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:random_user/model/user.dart';

class RandomUserApiClient {
  final http.Client httpClient;

  RandomUserApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List<User>> fetchUsers() async {
    final response = await httpClient.get(
      "https://randomuser.me/api/?results=10",
    );
    if (response.statusCode == 200) {
      final map = json.decode(response.body) as Map;
      List<dynamic> data = map["results"];
      return data.map((dynamic json) {
        return User.fromJson(json);
      }).toList();
    }
    throw Exception('error fetching users');
  }
}