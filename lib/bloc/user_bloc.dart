import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:random_user/bloc/user_event.dart';
import 'package:random_user/bloc/user_state.dart';
import 'package:http/http.dart' as http;
import 'package:random_user/repositories/random_user_api_client.dart';
import 'package:random_user/repositories/random_user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  final userRepository = RandomUserRepository(
      randomUserApiClient: RandomUserApiClient(httpClient: http.Client())
  );

  @override
  get initialState => UserState(status: UserStatus.initial);

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserFetched) {
      yield await _mapUserFetchedToState(state);
    }
  }

  Future<UserState> _mapUserFetchedToState(UserState state) async {
    try {
      if (state.status == UserStatus.initial) {
        final users = await userRepository.getUsers();
        return state.copyWith(
          status: UserStatus.success,
          users: users,
        );
      }
      final users = await userRepository.getUsers();
      return state.copyWith(
        status: UserStatus.success,
        users: state.users + users,
      );
    } on Exception {
      return state.copyWith(status: UserStatus.failure);
    }
  }
}