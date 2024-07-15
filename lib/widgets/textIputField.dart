import 'package:flutter/material.dart';
import 'Appcolors.dart';

Widget CommonTextField(String hint, String label, bool obscureText,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: obscureText,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontWeight: FontWeight.w400),
      labelText: label,
      labelStyle: TextStyle(
          color: AppColors.greyishColor,
          fontWeight: FontWeight.bold,
          fontSize: 17),
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
  );
}