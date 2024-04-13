// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:water_pathogen_detection_system/commonUtils/Constancts.dart';

class InputField extends StatefulWidget {
  final TextEditingController? controller;
  final String? lbltxt;
  final String? hnttxt;
  final TextInputType? kybrdtype;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;
  final bool isBlogsTextField;
  const InputField({
    this.controller,
    this.lbltxt,
    this.hnttxt,
    this.kybrdtype,
    this.padding,
    this.icon,
    this.isBlogsTextField = false, // Set default value to false
    super.key, // Added key parameter
  }); // Corrected the super constructor
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
        labelStyle: widget.isBlogsTextField!
            ? const TextStyle(
                color: primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )
            : const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
        hintText: widget.hnttxt,
        border: widget.isBlogsTextField!
            ? const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              )
            : const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ), // Default border color
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
        focusedBorder: widget.isBlogsTextField!
            ? const OutlineInputBorder(
                borderSide: BorderSide(
                  color: primaryColor,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              )
            : const UnderlineInputBorder(
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
