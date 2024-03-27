import 'package:flutter/material.dart';
import 'package:betterbee/components/CustomFormField.dart';
import 'package:betterbee/components/CustomButton.dart';
import 'package:betterbee/firebase/firebase_auth/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: FormSignUp());
  }
}

class FormSignUp extends StatefulWidget {
  const FormSignUp({super.key});

  @override
  State<FormSignUp> createState() => _FormSignUpState();
}

class _FormSignUpState extends State<FormSignUp> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String _errorPassword = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FireBaseAuthServices _auth =
      FireBaseAuthServices(); // Assurez-vous que cette classe existe et est correctement implémentée

  @override
  void initState() {
    super.initState();
    passwordController.addListener(_validatePasswords);
    confirmPasswordController.addListener(_validatePasswords);
  }

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
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.05,
        left: 10,
        right: 10,
      ),
      child: SingleChildScrollView(
        // Utilisez SingleChildScrollView
        child: Column(
          children: [
            const SizedBox(height: 60),
            Image.asset(
              'assets/animals/Bee.png', // Assurez-vous que ce chemin d'accès est correct
              width: MediaQuery.of(context).size.width * 0.55,
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                // Utilisez Column au lieu de ListView
                children: [
                  CustomFormField(
                    labelText: "Username",
                    keyboardType: TextInputType.name,
                    controller: usernameController,
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 25)),
                  CustomFormField(
                    labelText: "Mail",
                    keyboardType: TextInputType.emailAddress,
                    controller: mailController,
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 25)),
                  CustomFormField(
                    labelText: "Password",
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 25)),
                  CustomFormField(
                    labelText: "Confirm Password",
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    controller: confirmPasswordController,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Text(
                      _errorPassword,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  CustomButton(
                    text: "Sign Up",
                    onPressed: _signUp,
                    backgroundColor: Colors.amber,
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 40)),
                  _signInRedirect(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signUp() async {
    //String username = usernameController.text;
    String mail = mailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    String username = usernameController.text;

    if (password != confirmPassword) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Password are not the same"),
          backgroundColor: Colors.red,
        ));
        return;
      }
    }
    try {
      await _auth.signUpWithEmailAndPassword(mail, password, username);
      if (mounted) {
        Navigator.pushNamed(context, "/signIn");
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'weak-password') {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Password is weak"),
            backgroundColor: Colors.red,
          ));
        }
      }
      if (e.code == 'email-already-in-use') {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Email already used"),
            backgroundColor: Colors.red,
          ));
        }
      }

      if (e.code == 'invalid-email') {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Not a valid email "),
            backgroundColor: Colors.red,
          ));
        }
      }
    }
  }

  void _validatePasswords() {
    setState(() {
      _errorPassword = passwordController.text != confirmPasswordController.text
          ? "Passwords do not match"
          : "";
    });
  }

  Widget _signInRedirect() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?"),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/signIn');
          },
          child: const Text(
            "Sign In",
            style: TextStyle(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
