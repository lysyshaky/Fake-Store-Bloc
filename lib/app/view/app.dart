import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_store/authentication/authentication.dart';
import 'package:test_store/home/home.dart';
import 'package:test_store/l10n/l10n.dart';
import 'package:test_store/login/view/login_page.dart';
import 'package:test_store/splash/splash.dart';
import 'package:test_store/theme/theme.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatelessWidget {
  const App({
    required this.authenticationRepository,
    required this.userRepository,
    super.key,
  });

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider<AuthenticationBloc>(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({
    super.key,
  });

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      theme: appThemeData(),
      builder: (context, child) =>
          BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          switch (state.status) {
            case AuthenticationStatus.unknown:
              break;
            case AuthenticationStatus.authenticated:
              _navigator.pushAndRemoveUntil(HomePage.route(), (route) => false);
              break;
            case AuthenticationStatus.unauthenticated:
              _navigator.pushAndRemoveUntil(
                LoginPage.route(),
                (route) => false,
              );
              break;
          }
        },
        child: child,
      ),
      onGenerateRoute: (_) => SplashPage.route(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // home: LoginPage(),
    );
  }
}
