import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:test_store/login/bloc/login_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextLogo(size: size),
              SizedBox(height: size.height * 0.09),
              SizedBox(
                width: size.width * 0.8,
                child: const _UsernameInput(),
              ),
              SizedBox(height: size.height * 0.02),
              SizedBox(
                width: size.width * 0.8,
                child: _PasswordInput(),
              ),
              SizedBox(height: size.height * 0.02),
              ForgotPasswordText(),
              SizedBox(height: size.height * 0.07),
              _LoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          // Navigate to forgot password screen
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: const Text(
            'Forgot Password',
            style: TextStyle(
              color: Color.fromARGB(255, 35, 118, 124),
            ),
          ),
        ),
      ),
    );
  }
}

class TextLogo extends StatelessWidget {
  const TextLogo({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Text(
      'eComerce',
      style: GoogleFonts.playfairDisplay()
          .copyWith(fontSize: size.width * 0.14, fontWeight: FontWeight.bold),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  const _UsernameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextFormField(
          key: const Key('loginForm_usernameInput_textField'),
          style: TextStyle(color: Color.fromARGB(255, 31, 108, 114)),
          cursorColor: Color.fromARGB(255, 31, 108, 114),
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginUsernameChanged(username)),
          decoration: InputDecoration(
            focusColor: Color.fromARGB(255, 31, 108, 114),
            labelText: 'User name',
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
            ),
            errorText: state.username.invalid ? 'invalid username' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  _PasswordInput({super.key});

  FocusNode node = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          key: const Key('loginForm_passwordInput_textField'),
          obscureText: state.isPasswordObscure,
          cursorColor: Color.fromARGB(255, 31, 108, 114),
          style: TextStyle(
            color: Color.fromARGB(255, 31, 108, 114),
            decorationColor: Color.fromARGB(255, 31, 108, 114),
          ),
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          decoration: InputDecoration(
            focusColor: Color.fromARGB(255, 31, 108, 114),
            labelText: 'password',
            errorText: state.password.invalid ? 'invalid password' : null,
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
            ),
            suffixIcon: IconButton(
              color: Colors.grey.shade500,
              icon: Icon(
                state.isPasswordObscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
              onPressed: () => context.read<LoginBloc>().add(
                    LoginPasswordObscured(
                      isObscure: !state.isPasswordObscure,
                    ),
                  ),
            ),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : SizedBox(
                width: size.width * 0.8,
                height: size.height * 0.07,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      state.status.isValidated
                          ? Color.fromARGB(255, 31, 108, 114)
                          : Colors.grey.shade500,
                    ),
                  ),
                  onPressed: state.status.isValidated
                      ? () {
                          context.read<LoginBloc>().add(const LoginSubmitted());
                        }
                      : null,
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
      },
    );
  }
}
