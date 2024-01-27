import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final TextEditingController? controller;
  final String? lbltxt;
  final String? hnttxt;
  final TextInputType? kybrdtype;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;

  const InputField({
    this.controller,
    this.lbltxt,
    this.hnttxt,
    this.kybrdtype,
    this.padding,
    this.icon,
    Key? key, // Added key parameter
  }) : super(key: key); // Corrected the super constructor

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.kybrdtype,
      controller: widget.controller,
      obscureText: widget.icon == Icons.visibility_off
          ? !isPasswordVisible
          : false, // Toggle visibility based on the state only for password fields
      decoration: InputDecoration(
        suffixIcon: widget.icon == Icons.visibility_off
            ? GestureDetector(
                onTap: () {
                  if (widget.icon == Icons.visibility_off) {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  }
                },
                child: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black,
                  size: 24,
                ),
              )
            : Icon(
                widget.icon,
                color: Colors.black,
                size: 24,
              ),
        labelText: widget.lbltxt,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        hintText: widget.hnttxt,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1.0,
          ), // Default border color
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1.0,
          ), // Focused border color
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      ),
    );
  }
}
