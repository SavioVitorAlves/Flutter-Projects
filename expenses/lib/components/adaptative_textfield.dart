import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
class AdaptativeTextfield extends StatelessWidget {
  const AdaptativeTextfield({required this.label ,this.onSubmitted,  this.keyboardType = TextInputType.text ,required this.controller,super.key});

  final TextInputType? keyboardType;
  final TextEditingController controller;
  final Function(String)? onSubmitted;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CupertinoTextField(
        controller: controller,
        keyboardType: keyboardType,
        onSubmitted: onSubmitted,
        placeholder: label,
        padding: EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 12
        ),
      ),
    ) 
    : TextField(
      controller: controller,
      keyboardType: keyboardType,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}