import 'package:betterbee/firebase/firebase_call/firebase_call_services.dart';
import 'package:betterbee/routes.dart';
import 'package:betterbee/Provider.dart';
import 'package:betterbee/views/Animals.dart';
import 'package:betterbee/views/PrincipalView.dart';
import 'package:betterbee/views/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      create: (context) => AppProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthListenerWidget(),
    );
  }
}

class AuthListenerWidget extends StatefulWidget {
  const AuthListenerWidget({super.key});

  @override
  State<AuthListenerWidget> createState() => _AuthListenerWidgetState();
}

class _AuthListenerWidgetState extends State<AuthListenerWidget> {
  final FireBaseCallServices call = FireBaseCallServices();

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
      } else {
        Provider.of<AppProvider>(context, listen: false).setUid(user.uid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Vérifiez l'état de la connexion
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              call.setAnimal(snapshot.data!.uid, "Cat");
              return const PrincipalViewPage();
            } else {
              return const LoginPage();
            }
          }
          return const CircularProgressIndicator();
        },
      ),
      routes: {
        AppRoutes.signIn: (context) => const LoginPage(),
        AppRoutes.signUp: (context) => const CreateAccountPage(),
        AppRoutes.home: (context) => const PrincipalViewPage(),
        AppRoutes.animals: (context) => const Animals(),
      },
    );
  }
}
