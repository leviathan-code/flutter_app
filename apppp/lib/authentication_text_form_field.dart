import 'package:flutter/material.dart';

class AuthenticationTextFormField extends StatelessWidget {
  const AuthenticationTextFormField({
    Key? key,
    this.confirmationController,
    required this.icon,
    required this.label,
    required this.textEditingController,
  }) : super(key: key);

  final TextEditingController? confirmationController;
  final IconData icon;
  final String label;
  final TextEditingController textEditingController;

  String? validate({required String? value}) {
    if (value!.isEmpty) {
      return 'This field cannot be empty.';
    }

    if ((key.toString().contains('email')) &&
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value) == false) {
      return 'This is not a valid email address.';
    }

    if ((key.toString().contains('password')) && value.length < 6) {
      return 'The password must be at least 6 characters.';
    }

    if ((key.toString().contains('password_confirmation')) &&
        value != confirmationController?.text) {
      return 'The password does not match.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      obscureText: label.toLowerCase().contains('password'),
      decoration: InputDecoration(
        errorStyle: const TextStyle(fontSize: 14),
        floatingLabelStyle: const TextStyle(fontSize: 20),
        icon: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        labelText: label,
      ),
      validator: (value) => validate(value: value),
    );
  }
}