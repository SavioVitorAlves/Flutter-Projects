//CONSTRUINDO A FUTEREBUILDER

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async'; //nao fica esperando
import 'dart:convert'; //transformar em json

const request = "https://api.hgbrasil.com/finance?key=faf29c91";

void main() async {
  print(await getData());

  runApp(MaterialApp(
    home: Home(),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(request));
  return (json.decode(response.body));
}


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text("Carregando dados....",
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 25),
                    textAlign: TextAlign.center,),
                );
              case ConnectionState.active:
                return Center(child:
                CircularProgressIndicator()
                );
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Erro Ao carregar os dados",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }else{
                  // Dados carregados com sucesso, exiba os dados aqui
                  return Text(snapshot.data!['resultado'].toString());
                  /*return Container(
                    color: Colors.green,
                  );*/
                }
            }
          }),
    );
  }
}
//conversor de Moedas - parte 3.txt
//Exibindo conversor de Moedas - parte 3.txt…