import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';

class StartView extends StatelessWidget {
  const StartView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Google Sign-In (MVVM)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await viewModel.signInWithGoogle();
                if (viewModel.errorMessage != null) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(viewModel.errorMessage!)),
                    );
                  }
                } else {
                  await viewModel.addUser(viewModel.userModel!);
                  if (context.mounted) {
                    context.go('/home');
                  }
                }
              },
              child: const Text('Sign in with Google'),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/signin');
              },
              child: const Text('Sign in with Email'),
            ),
            ElevatedButton(
              onPressed: () async {
                await viewModel.signInAnonymously();
                if (viewModel.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(viewModel.errorMessage!)),
                  );
                } else {
                  await viewModel.addUser(viewModel.userModel!);
                  if (context.mounted) {
                    context.go('/home');
                  }
                }
              },
              child: const Text('Continue as guest'),
            ),
          ],
        ),
      ),
    );
  }
}
