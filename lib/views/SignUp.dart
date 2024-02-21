import 'package:betterbee/components/CustomFormField.dart';
import 'package:betterbee/components/CustomButton.dart';
import 'package:betterbee/user_auth/firebase_auth/firebase_auth_services.dart';
import 'package:betterbee/views/SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPage();
}

class _CreateAccountPage extends State<CreateAccountPage> {
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
        body: FormSignUp());
  }
}

class FormSignUp extends StatefulWidget {
  const FormSignUp({super.key});

  @override
  State<FormSignUp> createState() => _FormSignUp();
}

class _FormSignUp extends State<FormSignUp> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FireBaseAuthServices _auth = FireBaseAuthServices();

  @override
  void dispose() {
    usernameController.dispose();
    mailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 190, left: 10, right: 10),
        child: Form(
            key: _formKey,
            child: ListView(key: UniqueKey(), children: [
              CustomFormField(
                  labelText: "Username",
                  keyboardType: TextInputType.name,
                  controller: usernameController),
              const Padding(padding: EdgeInsets.only(bottom: 25)),
              CustomFormField(
                  labelText: "Mail",
                  keyboardType: TextInputType.emailAddress,
                  controller: mailController),
              const Padding(padding: EdgeInsets.only(bottom: 25)),
              CustomFormField(
                  labelText: "Password",
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController),
              const Padding(padding: EdgeInsets.only(bottom: 25)),
              CustomFormField(
                  labelText: "Confirm Password",
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  controller: confirmPasswordController),
              const Padding(padding: EdgeInsets.only(bottom: 25)),
              CustomButton(text: "Sign Up", onPressed: _signUp),
              const Padding(padding: EdgeInsets.only(bottom: 40)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    child: const Text(
                      "Sign In",
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

  void _signUp() async {
    String username = usernameController.text;
    String mail = mailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (password != confirmPassword) {
      print("Passwords do not match");
      return;
    }

    User? user = await _auth.signUpWithEmailAndPassword(mail, password);

    if (user != null) {
      print("User created");
      Navigator.pushNamed(context, "/login");
    } else {
      print("User not created");
    }
  }
}
