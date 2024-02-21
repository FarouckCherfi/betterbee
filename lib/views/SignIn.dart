import 'package:betterbee/components/CustomButton.dart';
import 'package:betterbee/components/CustomFormField.dart';
import 'package:flutter/material.dart';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:betterbee/views/SignUp.dart';

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
  State<FormSignIn> createState() => _FormSignIn();
}

class _FormSignIn extends State<FormSignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 190, left: 10, right: 10),
        child: Form(
            key: _formKey,
            child: ListView(key: UniqueKey(), children: [
              const CustomFormField(
                  labelText: "Mail", keyboardType: TextInputType.emailAddress),
              const Padding(padding: EdgeInsets.only(bottom: 25)),
              const CustomFormField(
                  labelText: "Password",
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword),
              const Padding(padding: EdgeInsets.only(bottom: 25)),
              CustomButton(text: "Login", onPressed: () => ()),
              const Padding(padding: EdgeInsets.only(bottom: 40)),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreateAccountPage()));
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  )
                ],
              )
            ])));
  }
}
