import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
class AdaptativeButton extends StatelessWidget {
  const AdaptativeButton({super.key, required this.label, required this.onPressed});
  
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? CupertinoButton(
      child: Text(label),
      onPressed: onPressed,
      color: Theme.of(context).colorScheme.primary,
      padding: EdgeInsets.symmetric(horizontal: 20),
      )
      : ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
        style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.purple),
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white), // Define a cor do texto
        ),
        );
  }
}