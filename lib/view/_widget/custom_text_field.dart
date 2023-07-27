import 'package:flutter/material.dart';
import 'package:fluttersqflite/core/extension/context_extension.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key, this.controller, this.keyboardType, this.hintText});
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: context.colors.secondary,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: context.colors.onPrimary,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
