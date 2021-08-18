import 'package:equatable/equatable.dart';

abstract class CredentialsEvent extends Equatable {
  /// The username

  final String userName;

  ///The password
  final String password;

  /// Events fired by [CredentialsBloc] when a button is pressed. It
  /// provides information taken from the form.
  CredentialsEvent({required this.userName, required this.password});
  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends CredentialsEvent {
  LoginButtonPressed({required String userName, required String password})
      : super(userName: userName, password: password);
}

class RegisterButtonPressed extends CredentialsEvent {
  RegisterButtonPressed({required String userName, required String password})
      : super(userName: userName, password: password);
}
