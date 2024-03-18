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
    return const Scaffold(body: FormSignIn());
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

  final FocusNode _mailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FireBaseAuthServices _auth = FireBaseAuthServices();

  @override
  void dispose() {
    _mailController.dispose();
    _passwordController.dispose();
    _mailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();

      if (googleSignInAccount == null) {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            // Utilisez SingleChildScrollView pour permettre le défilement lorsque le clavier apparaît
            child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1,
                  left: 10,
                  right: 10,
                ),
                child: Column(children: [
                  const SizedBox(height: 60),
                  Image.asset(
                    'assets/animals.png', // Assurez-vous que ce chemin d'accès est correct
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                  const SizedBox(height: 20),
                  Form(
                      key: _formKey,
                      child: Column(
                        // Remplacez ListView par Column
                        children: [
                          CustomFormField(
                            labelText: "Mail",
                            keyboardType: TextInputType.emailAddress,
                            controller: _mailController,
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 25)),
                          CustomFormField(
                            labelText: "Password",
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passwordController,
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 25)),
                          CustomButton(
                            text: "Login",
                            onPressed: _signIn,
                            backgroundColor: Colors.amber,
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 20)),
                          const Row(children: [
                            Expanded(
                              child: Divider(
                                color: Colors.black87,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'or',
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.black87,
                              ),
                            )
                          ]),
                          FilledButton.icon(
                            onPressed: _signInWithGoogle,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(179, 140, 140, 140),
                              ),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            icon: const Icon(Icons.g_mobiledata_rounded),
                            label: const Text('Sign in with Google'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
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
                                    fontSize: 15,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ))
                ]))));
  }

  void _signIn() async {
    String mail = _mailController.text;
    String password = _passwordController.text;

    try {
      User? user = await _auth.signInWithEmailAndPassword(mail, password);
      String? username = await _auth.getCurrentUser(user!.uid);
      if (mounted) {
        Navigator.pushNamed(context, "/home",
            arguments: {'username': username});
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
