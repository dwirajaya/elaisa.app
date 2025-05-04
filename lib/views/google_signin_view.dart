import 'package:flutter/material.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../models/user_model.dart';

class GoogleSignInView extends StatefulWidget {
  const GoogleSignInView({super.key});

  @override
  _GoogleSignInViewState createState() => _GoogleSignInViewState();
}

class _GoogleSignInViewState extends State<GoogleSignInView> {
  final AuthViewModel _authViewModel = AuthViewModel();
  UserModel? _user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Sign-In (MVVM)')),
      body: Center(
        child:
            _user == null
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final user = await _authViewModel.signInWithGoogle();
                        setState(() {
                          _user = user;
                        });
                        if (user != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Signed in as ${user.displayName}'),
                            ),
                          );
                        }
                      },
                      child: const Text('Sign in with Google'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final user = await _authViewModel.signInAnonymously();
                        setState(() {
                          _user = user;
                        });
                        if (user != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Signed in as anonymously')),
                          );
                        }
                      },
                      child: const Text('Continue as guest'),
                    ),
                  ],
                )
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(_user!.photoUrl ?? ''),
                      radius: 40,
                    ),
                    const SizedBox(height: 10),
                    Text('Name: ${_user!.displayName}'),
                    Text('Email: ${_user!.email}'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        await _authViewModel.signOut();
                        setState(() {
                          _user = null;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Signed out')),
                        );
                      },
                      child: const Text('Sign out'),
                    ),
                  ],
                ),
      ),
    );
  }
}
