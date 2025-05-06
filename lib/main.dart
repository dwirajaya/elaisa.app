import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'theme/theme.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'services/router_service.dart';

// to run: flutter run -d chrome

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kDebugMode) {
    try {
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AuthViewModel())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    final router = RouterService();

    // Retrieves the default theme for the platform
    //TextTheme textTheme = Theme.of(context).textTheme;

    /*
    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(
      context,
      "Merriweather Sans",
      "Playfair Display",
    );
    */
    TextTheme textTheme = TextTheme(
      displayLarge: const TextStyle(
        fontFamily: 'Playfair Display',
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      bodyLarge: const TextStyle(
        fontFamily: 'Merriweather Sans',
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      bodyMedium: const TextStyle(
        fontFamily: 'Merriweather Sans',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
    );
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp.router(
      title: 'Flutter Demo New',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      routerConfig: router.router,
    );
  }
}

// TODO 1. Theme. 2. Go router 3. Navigation after login
