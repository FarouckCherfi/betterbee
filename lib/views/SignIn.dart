import 'package:betterbee/components/CustomButton.dart';
import 'package:betterbee/components/CustomFormField.dart';
import 'package:betterbee/user_auth/firebase_auth/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FireBaseAuthServices _auth = FireBaseAuthServices();

  @override
  void dispose() {
    _mailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();

      if (googleSignInAccount == null) {
        // User canceled the sign-in
        return;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
         await FirebaseAuth.instance.signInWithCredential(credential);

      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, "/home");
    } catch (e) {
      print("Error signing in with Google: $e");
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 190, left: 10, right: 10),
        child: Form(
            key: _formKey,
            child: ListView(key: UniqueKey(), children: [
              CustomFormField(
                  labelText: "Mail",
                  keyboardType: TextInputType.emailAddress,
                  controller: _mailController),
              const Padding(padding: EdgeInsets.only(bottom: 25)),
              CustomFormField(
                  labelText: "Password",
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordController),
              const Padding(padding: EdgeInsets.only(bottom: 25)),
              CustomButton(
                text: "Login",
                onPressed: _signIn,
                backgroundColor: Colors.amber,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 40)),
              FilledButton.icon(
                onPressed: _signInWithGoogle,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(179, 250, 241, 241)),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                icon: const Icon(Icons.g_mobiledata_rounded
                ),

                label: const Text('Sign in with Google'),

                // <-- Text
              ),
              //GoogleSignInButton(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signUp');
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

  void _signIn() async {
    String mail = _mailController.text;
    String password = _passwordController.text;

    try {
      await _auth.signInWithEmailAndPassword(mail, password);
      if (mounted) {
        Navigator.pushNamed(context, "/home");
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Email or Password is not valid"),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      if (mounted) {}
    }
  }
}
