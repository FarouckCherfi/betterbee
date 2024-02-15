import 'package:betterbee/components/CustomFormField.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}


class _LoginPage extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.amber,
        destinations: const <Widget>[
          NavigationDestination(
              icon: Icon(Icons.home_filled),
              label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.notification_add),
              label: "Notifications"),
          NavigationDestination(
              icon: Icon(Icons.contacts),
              label: "Friends"),
        ]
      ),
      body : const FormSignUp()
    );
  }
}

class FormSignUp extends StatefulWidget {
  const FormSignUp({super.key});

  @override
  State<FormSignUp> createState() => _FormSignUp();
}

class _FormSignUp extends State<FormSignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    return Padding(
      padding : const EdgeInsets.only(top: 250,left: 10,right:10),
      child : Form(
          key:_formKey,
          child: ListView (
            key : UniqueKey(),
            children : const [
              CustomFormField(labelText: "Mail", keyboardType: TextInputType.emailAddress),
              Padding(padding: EdgeInsets.only(bottom: 15)),
              CustomFormField(labelText: "Password",obscureText: true,keyboardType : TextInputType.visiblePassword)
          ]

      )
        )
      );
  }
}
