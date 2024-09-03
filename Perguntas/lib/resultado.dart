import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  final int pontuacao;
  final void Function() quandoReiniciarQuestionario;
  
  const Resultado(this.pontuacao, this.quandoReiniciarQuestionario, { super.key});

  String get fraseResultado{
    if (pontuacao < 8){
      return 'Parabens!';
    }else if(pontuacao < 12){
      return 'Você é muito bom!';
    }else if(pontuacao < 16){
      return 'Impecionante!';
    }else{
      return 'Nivel Jedi!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Text(
            fraseResultado,
            style: const TextStyle(
              fontSize: 28
            ),
          ),
      ),
      ElevatedButton(
        onPressed: quandoReiniciarQuestionario, 
        child: const Text('Reinicar',
          style: TextStyle(fontSize: 18, color: Colors.blue),
        )
        )
      ],
    );
  }
}