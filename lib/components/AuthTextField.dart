// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

extension extString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp =
        new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull {
    // ignore: unnecessary_null_comparison
    return this != null;
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }
}

// ignore: must_be_immutable
class AuthTextField extends StatelessWidget {
  final submit;
  final widthh;
  double? labelfont;
  final controller;
  final suffixIcon;
  final validator;
  final isPassword;
  final labelText;
  final prefixIcon;
  final hint;
  double? fontsiz;
  final colors;
  var icon;
  AuthTextField({
    Key? key,
    this.labelfont,
    this.submit,
    this.colors,
    this.fontsiz,
    this.controller,
    this.hint,
    this.validator,
    this.icon,
    this.suffixIcon,
    required this.widthh,
    required this.isPassword,
    this.prefixIcon,
    this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widthh,
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onEditingComplete: submit,
          validator: validator,
          controller: controller,
          style: TextStyle(
            color: Colors.white,
          ),
          cursorColor: colors,
          obscureText: isPassword,
          decoration: InputDecoration(
            errorStyle: TextStyle(
              color: Colors.redAccent,
              fontSize: null,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent),
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding: EdgeInsets.all(16),
            prefixIcon: prefixIcon,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            alignLabelWithHint: true,
            hintText: hint,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: fontsiz,
              color: Colors.white,
            ),
            fillColor: Colors.transparent,
            filled: true,
            labelStyle: TextStyle(color: Colors.white, fontSize: labelfont),
            suffixIcon: suffixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.white),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.white),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ));
  }
}
