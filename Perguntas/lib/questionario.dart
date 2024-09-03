import 'package:flutter/material.dart';
import 'questao.dart';
import 'resposta.dart';

class Questionario extends StatelessWidget {
  final List<Map<String, Object>> perguntas;
  final int perguntaSelecionada;
  final void Function(int) quandoResponder;

  const Questionario({super.key,
    required this.perguntaSelecionada,
    required this.perguntas,
    required this.quandoResponder,
  });
  bool get temPerguntaSelecionanda{
      return perguntaSelecionada < perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> respostas = temPerguntaSelecionanda ? perguntas[perguntaSelecionada]['respostas'] 
    as List<Map<String, Object>>
    :[];
    return Column(
          children: [
            Questao(perguntas[perguntaSelecionada]["texto"].toString()),
           ...respostas.map((res){
              return Resposta(
                res['texto'] as String, 
                () => quandoResponder(int.parse(res['pontuacao'].toString())),
           );
          }),
          ],
        );
  }
}