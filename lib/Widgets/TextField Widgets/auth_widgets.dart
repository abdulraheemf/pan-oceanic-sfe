import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  String description;
  bool isObscure;
  CustomTextField({super.key, required this.description,this.isObscure=false});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 30),
      child: Row(
        children: [
          Text(widget.description),
          Expanded(child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: TextFormField(
              obscureText: widget.isObscure,
              keyboardType: (widget.isObscure)?TextInputType.text:TextInputType.emailAddress,
            ),
          ))
        ],
      ),
    );
  }
}
