import 'package:flutter/material.dart';

class ReusableTextFormField extends StatefulWidget {
  ReusableTextFormField({
    required this.text,
    required this.prefix,
    required this.textInputType,
    required this.controller,
    this.validator,
  });

  final String text;
  final Icon prefix;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  _ReusableTextFormFieldState createState() => _ReusableTextFormFieldState();
}

class _ReusableTextFormFieldState extends State<ReusableTextFormField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12.0,
        left: 10.0,
        right: 10.0,
        bottom: 0.0,
      ),
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.grey[300],
          filled: true,
          hintText: widget.text,
          prefixIcon: widget.prefix,
          suffixIcon: widget.textInputType == TextInputType.visiblePassword
              ? InkWell(
            onTap: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: _isObscure ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
            ),
          )
              : null,
        ),
        keyboardType: widget.textInputType,
        obscureText: widget.textInputType == TextInputType.visiblePassword ? _isObscure : false,
      ),
    );
  }
}
