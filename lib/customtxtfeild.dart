import 'package:flutter/material.dart';

class customtxtformfeild extends StatelessWidget {
  const customtxtformfeild(
      {super.key,
      required this.Controller,
      required this.labeltext,
      required this.warning});

  final TextEditingController Controller;
  final String labeltext;
  final String warning;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: Controller,
      decoration: InputDecoration(
        labelText: labeltext,
        border: UnderlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return (warning);
        }
        return null;
      },
    );
  }
}
