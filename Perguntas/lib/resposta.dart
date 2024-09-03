import 'package:flutter/material.dart';

class Resposta extends StatelessWidget {
  final String text;
  final void Function() quandoSelecionado;

  const Resposta(this.text, this.quandoSelecionado, {super.key});
  
  @override 
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: ElevatedButton(
        onPressed: quandoSelecionado,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow,
          side: const BorderSide(color: Color.fromARGB(255, 48, 61, 71), width: 2.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          padding: EdgeInsets.zero,
        ), 
        child: Text(text,
          style: const TextStyle(color: Colors.black),
        ),

      ),
    );
  }
}