import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_authentication/blocs/authentication_bloc.dart';
import 'package:mobile_authentication/blocs/login_bloc/events.dart';
import 'package:mobile_authentication/blocs/login_bloc/state.dart';
import 'package:mobile_authentication/repository/user_repository.dart';

/// Manages the login state of the app

class CredentialsBloc extends Bloc<CredentialsEvent, CredentialsState> {
  /// Data about the user

  final UserRepository userRepository;

  /// The [AuthenticationBloc] taking care of changing pages
  final AuthenticationBloc authenticationBloc;

  CredentialsBloc(
      {required this.userRepository, required this.authenticationBloc})
      : super(const CredentialInitial());

  /// Creates a Bloc taking care of managing the login state of the app.

  @override
  Stream<CredentialsState> mapEventToState(CredentialsEvent event) async* {
    if (event is LoginButtonPressed) {
      yield* _loginPressed(event);
    }
    if (event is RegisterButtonPressed) {
      yield* _registerPressed(event);
    }
  }

  Stream<CredentialsState> _loginPressed(CredentialsEvent event) async* {
    yield const CredentialLoginLoading();

    try {
      bool myBool = await userRepository.login(event.userName, event.password);

      print('my bool is $myBool');
      if (myBool) {
        authenticationBloc.add(LoggedIn());
      }

      yield myBool ? const CredentialInitial() : const CredentialLoginFailure();
    } on FirebaseAuthException {
      yield const CredentialLoginFailure();
    }
  }

  Stream<CredentialsState> _registerPressed(CredentialsEvent event) async* {
    yield const CredentialLoginLoading();

    try {
      await userRepository.register(event.userName, event.password);
      authenticationBloc.add(LoggedIn());
      yield const CredentialInitial();
    } on FirebaseAuthException {
      yield const CredentialRegisterFailure();
    }
  }
}
