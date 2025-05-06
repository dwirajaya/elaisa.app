import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(viewModel.userModel?.photoUrl ?? ''),
            radius: 40,
          ),
          const SizedBox(height: 10),
          Text('Name: ${viewModel.userModel?.displayName}'),
          Text('Email: ${viewModel.userModel?.email}'),
          Text('UID: ${viewModel.uid}'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await viewModel.signOut();
              if (viewModel.errorMessage != null) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Error signing out.')),
                  );
                }
              } else {
                if (context.mounted) {
                  context.go('/start');
                }
              }
            },
            child: const Text('Sign out'),
          ),
        ],
      ),
    );
  }
}
