import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final TextEditingController? controller;
  final String? lbltxt;
  final String? hnttxt;
  final TextInputType? kybrdtype;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;

  const InputField(
      {this.controller,
      this.lbltxt,
      this.hnttxt,
      this.kybrdtype,
      this.padding,
      this.icon,
      super.key});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        keyboardType: widget.kybrdtype,
        controller: widget.controller,
        decoration: InputDecoration(
            suffixIcon: Icon(
              widget.icon,
              color: Colors.grey,
              size: 24,
            ),
            labelText: widget.lbltxt,
            labelStyle: const TextStyle(
              color: Color(0xffB81736),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            hintText: widget.hnttxt,
            border: const UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black, width: 1.0), // Default border color
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black, width: 1.0), // Focused border color
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0)));
  }
}
