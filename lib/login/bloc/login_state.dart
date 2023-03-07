part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.isPasswordObscure = true,
  });

  final FormzStatus status;
  final Username username;
  final Password password;
  final bool isPasswordObscure;

  LoginState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
    bool? isObscure,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      isPasswordObscure: isObscure ?? isPasswordObscure,
    );
  }

  @override
  List<Object> get props => [status, username, password, isPasswordObscure];
}
