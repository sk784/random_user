import 'package:random_user/model/user.dart';

enum UserStatus { initial, success, failure }

class UserState {
  final UserStatus status;
  final List<User> users;

  const UserState({
    this.status = UserStatus.initial,
    this.users = const <User>[],
  });

  UserState copyWith({
    UserStatus status,
    List<User> users,
  }) {
    return UserState(
      status: status ?? this.status,
      users: users ?? this.users,
    );
  }
}