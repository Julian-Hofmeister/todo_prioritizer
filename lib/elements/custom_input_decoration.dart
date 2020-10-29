import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
InputDecoration CustomInputDecoration(String hintText) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: hintText,
    contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
    focusedBorder: OutlineInputBorder(
      borderSide: new BorderSide(color: Colors.white),
      borderRadius: new BorderRadius.circular(5),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: new BorderSide(color: Colors.white),
      borderRadius: new BorderRadius.circular(5),
    ),
  );
}
