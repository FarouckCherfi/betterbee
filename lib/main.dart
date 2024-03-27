import 'package:betterbee/routes.dart';
import 'package:betterbee/Provider.dart';
import 'package:betterbee/views/Animals.dart';
import 'package:betterbee/views/PrincipalView.dart';
import 'package:betterbee/views/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:betterbee/views/SignIn.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => UserProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: AppRoutes.signIn, routes: {
      AppRoutes.signIn: (context) => const LoginPage(),
      AppRoutes.signUp: (context) => const CreateAccountPage(),
      AppRoutes.home: (context) => const PrincipalViewPage(),
      AppRoutes.animals: (context) => const Animals(),
    });
  }
}
