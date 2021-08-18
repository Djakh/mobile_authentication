import 'package:equatable/equatable.dart';

/// States emitted by [CredentialsBloc]

abstract class CredentialsState extends Equatable {
  /// State emitted by [CredentialsBloc] when the form is created
  const CredentialsState();

  @override
  List<Object> get props => [];
}

/// Action required (authentication or registration)

class CredentialInitial extends CredentialsState {
  const CredentialInitial();
}

/// Login request awaiting for response
class CredentialLoginLoading extends CredentialsState {
  const CredentialLoginLoading();
}

/// Registration request awaiting for response

class CredentialRegisterLoading extends CredentialsState {
  const CredentialRegisterLoading();
}

/// Invalid authentication credentials
class CredentialLoginFailure extends CredentialsState {
  const CredentialLoginFailure();
}

/// Invalid register credentials
class CredentialRegisterFailure extends CredentialsState {
  const CredentialRegisterFailure();
}
