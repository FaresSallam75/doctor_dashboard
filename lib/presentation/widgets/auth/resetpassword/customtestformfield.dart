import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final TextInputType? keyboardType;
  final IconData? icon;
  final bool? obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.keyboardType,
    required this.icon,
    required this.obscureText,
    required this.suffixIcon,
    required this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            obscureText: obscureText!,
            validator: validator,
            decoration: InputDecoration(
              prefixIcon: Icon(icon),
              labelText: labelText,

              suffixIcon: suffixIcon,
            ),
            keyboardType: keyboardType,
          ),
        ),
      ],
    );
  }
}