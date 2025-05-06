import 'package:elaisa_app/views/home_view.dart';
import 'package:elaisa_app/views/start_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';

class AuthGateView extends StatelessWidget {
  const AuthGateView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);

    return StreamBuilder(
      stream: viewModel.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            String? uid = snapshot.data?.uid;
            if (uid != null) {
              viewModel.uid = uid;
              return HomeView();
            }
          }
          return StartView();
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
