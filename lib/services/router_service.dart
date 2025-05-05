import 'package:elaisa_app/views/auth_gate_view.dart';
import 'package:elaisa_app/views/email_signin_view.dart';
import 'package:elaisa_app/views/email_signup_view.dart';
import 'package:elaisa_app/views/home_view.dart';
import 'package:elaisa_app/views/start_view.dart';
import 'package:go_router/go_router.dart';

class RouterService {
  GoRouter get router => _router;

  final GoRouter _router = GoRouter(
    initialLocation: '/gate',
    routes: <GoRoute>[
      GoRoute(path: '/gate', builder: (context, state) => AuthGateView()),
      GoRoute(path: '/start', builder: (context, state) => StartView()),
      GoRoute(path: '/home', builder: (context, state) => HomeView()),
      GoRoute(path: '/signin', builder: (context, state) => EmailSignInView()),
      GoRoute(path: '/signup', builder: (context, state) => EmailSignUpView()),
    ],
  );
}
