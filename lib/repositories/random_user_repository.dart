import 'package:random_user/model/user.dart';
import 'package:random_user/repositories/random_user_api_client.dart';

class RandomUserRepository {
  final RandomUserApiClient randomUserApiClient;

  RandomUserRepository({this.randomUserApiClient})
      : assert(randomUserApiClient != null);

  Future<List<User>> getUsers() async {
    return randomUserApiClient.fetchUsers();
  }
}