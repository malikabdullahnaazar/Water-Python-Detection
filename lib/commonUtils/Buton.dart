import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String btntxt;
  final VoidCallback onPressed;
  Button({required this.btntxt,required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width / 2 + 50,
            height: MediaQuery.of(context).size.height * 0.1 - 25,
            child: Text(
              btntxt,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            )));
  }
}
