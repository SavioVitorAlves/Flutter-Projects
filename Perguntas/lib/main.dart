import 'package:flutter/material.dart';
import 'questionario.dart';
import 'resultado.dart';
void main(){
  runApp(const PerguntaApp());
}

class PerguntaAppState extends State<PerguntaApp>{
  var _perguntaSelecionada = 0;
  var _pontuacaoTotal = 0;
  
  final List<Map<String, Object>> _perguntas = const [
      {
        'texto': "Qual é sua cor favorita?",
        'respostas': [
          {'texto': 'Preto', 'pontuacao': 10},
          {'texto': 'Branco','pontuacao': 5},
          {'texto': 'Azul','pontuacao': 3},
          {'texto': 'Vermelho','pontuacao': 1},
        ],
      },
      {
        'texto': "Qual é seu animal favorito?",
        'respostas': [
          {'texto': 'Cachorro','pontuacao': 10},
          {'texto': 'Gato','pontuacao': 5},
          {'texto': 'Peixe','pontuacao': 3},
          {'texto': 'Calopsita','pontuacao': 1},
        ],
      },
    ];
    bool get temPerguntaSelecionanda{
      return _perguntaSelecionada < _perguntas.length;
  }

  @override
  Widget build(BuildContext context){

    void _responder(int pontuacao){
      if (temPerguntaSelecionanda) {
        setState(() {
        _perguntaSelecionada++;
        _pontuacaoTotal += pontuacao;
      });  
      }
      print(_pontuacaoTotal);
    }

    void _reiniciarQuestionario(){
      setState(() {
        _perguntaSelecionada = 0;
        _pontuacaoTotal = 0;  
      });
    }

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
          title: const Text("Perguntas"),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: temPerguntaSelecionanda ? Questionario(perguntaSelecionada: _perguntaSelecionada, perguntas: _perguntas, quandoResponder: _responder) : Resultado(_pontuacaoTotal, _reiniciarQuestionario)
      ),
    );
  }
}
class PerguntaApp extends StatefulWidget{
  const PerguntaApp({Key? key}) : super(key: key);
  
  @override
  PerguntaAppState createState(){
    return PerguntaAppState();
  } 
  
}
