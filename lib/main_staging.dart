import 'package:authentication_repository/authentication_repository.dart';
import 'package:test_store/app/app.dart';
import 'package:test_store/bootstrap.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  bootstrap(
    () => App(
      authenticationRepository: AuthenticationRepository(),
      userRepository: UserRepository(),
    ),
  );
}
