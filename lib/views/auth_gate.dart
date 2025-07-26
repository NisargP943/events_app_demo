import 'package:events_app/provider/events_provider.dart';
import 'package:events_app/views/auth/login_page.dart';
import 'package:events_app/views/home/home_page.dart';
import 'package:events_app/views/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      loading: () => const SplashPage(),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (user) {
        if (user != null) {
          print("this is called");
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
