import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFormWidgets extends StatelessWidget {
  TextFormWidgets({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
  });
  TextEditingController? controller;
  String? hintText;
  String? labelText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black),
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      controller: controller,
      minLines: null,
      style: const TextStyle(color: Colors.black),
    );
  }
}
