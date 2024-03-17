import 'package:flutter/material.dart';
import 'package:apppp/authentication_text_form_field.dart';
import 'package:apppp/list.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  bool register = true;

  Future<void> _authenticate() async {
    if (_formKey.currentState!.validate() == false) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Success', textAlign: TextAlign.center, style: TextStyle(fontSize: 20),)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // const Wave(),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  AuthenticationTextFormField(
                    key: const Key('email'),
                    icon: Icons.email,
                    label: 'Email',
                    textEditingController: emailController,
                  ),
                  AuthenticationTextFormField(
                    key: const Key('password'),
                    icon: Icons.vpn_key,
                    label: 'Password',
                    textEditingController: passwordController,
                  ),
                  if (register == true)
                    AuthenticationTextFormField(
                      key: const Key('password_confirmation'),
                      confirmationController: passwordController,
                      icon: Icons.password,
                      label: 'Password Confirmation',
                      textEditingController: passwordConfirmationController,
                    ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: const StadiumBorder(),
                    ),
                    onPressed: (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ListScreen()),
                      );
                    },
                    child: Text(
                      register == true ? 'Register' : 'Login',
                      style: const TextStyle(fontSize: 17.5),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () => setState(() {
                      register = !register;
                      _formKey.currentState?.reset();
                    }),
                    child: Text(
                      register == true ? 'Login instead' : 'Register instead',
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}