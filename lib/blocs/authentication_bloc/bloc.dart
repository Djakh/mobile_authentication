import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_authentication/blocs/authentication_bloc/events.dart';
import 'package:mobile_authentication/blocs/authentication_bloc/state.dart';
import 'package:mobile_authentication/repository/user_repository.dart';

/// Manages the authentication state of the app
class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc(this.userRepository) : super(AuthenticationInit());

   @override
Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async*{
if (event is LoggedIn) {
yield const AuthenticationSuccess();
}
if (event is LoggedOut) {
yield const AuthenticationLoading();
await userRepository.logOut();
yield const AuthenticationRevoked();
}
}
}
