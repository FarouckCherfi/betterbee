import 'package:betterbee/components/CustomFormField.dart';
import 'package:flutter/material.dart';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        //bottomNavigationBar: NavigationBar(
        //  backgroundColor: Colors.amber,
        // destinations: const <Widget>[
        //  NavigationDestination(
        //     icon: Icon(Icons.home_filled), label: 'Home'),
        // NavigationDestination(
        //     icon: Icon(Icons.notification_add), label: "Notifications"),
        //NavigationDestination(
        //   icon: Icon(Icons.contacts), label: "Friends"),
        //]),
        body: FormSignIn());
  }
}

class FormSignIn extends StatefulWidget {
  const FormSignIn({super.key});

  @override
  State<FormSignIn> createState() => _FormSignUp();
}

class _FormSignUp extends State<FormSignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 250, left: 10, right: 10),
        child: Form(
            key: _formKey,
            child: ListView(key: UniqueKey(), children: [
              const CustomFormField(
                  labelText: "Mail", keyboardType: TextInputType.emailAddress),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              const CustomFormField(
                  labelText: "Password",
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              SignInWithAppleButton(
                onPressed: () async {
                  final credential = await SignInWithApple.getAppleIDCredential(
                    scopes: [
                      AppleIDAuthorizationScopes.email,
                      AppleIDAuthorizationScopes.fullName,
                    ],
                  );
                  print(credential);
                },
              ),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
            ])));
  }
}
