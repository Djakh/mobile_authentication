import 'package:bloc_test/bloc_test.dart';
import 'package:mobile_authentication/blocs/authentication_bloc.dart';
import 'package:mobile_authentication/blocs/authentication_bloc/bloc.dart';
import 'package:mobile_authentication/repository/user_repository/test_repository.dart';

void main() {
  final authenticationRepository = const TestUserRepository(
    fakeEmail: "alberto@miola.it",
    success: true,
  );




}