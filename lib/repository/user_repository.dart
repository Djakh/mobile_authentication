// Inside 'repository/user_repository.dart'
abstract class UserRepository {
/// Creates the repository for authenticating an user
const UserRepository();

/// Email of the signed user
String get signedEmail;

/// Login with username and password
Future<bool> login(String userName, String password);

/// Registration with username and password
Future<bool> register(String userName, String password);

///Logout
Future<void> logOut();


}