//CONSTRUINDO A FUTEREBUILDER

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async'; //nao fica esperando
import 'dart:convert'; //transformar em json

const request = "https://api.hgbrasil.com/finance?key=6417ae14";

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
  String? selectedItem;
  String? selectedItem2;
  double inputValue = 0.0;
  double result = 0.0;
  Map? currencies;

  double conversao(double moeda, double valor){
    double valorConvertido = valor * moeda;
    return valorConvertido;
  }

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
                  //return Text(snapshot.data!['resultado'].toString());
                  currencies = snapshot.data!["results"]["currencies"];
                  // Filtra as chaves para excluir "source" e pegar apenas as moedas
                  final currencyKeys = currencies!.keys.where((key) => key != "source").toList();
                  
                  return Container(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownButton<String>(
                              hint: Text(
                                'Escolha uma moeda',
                                style: TextStyle(color: Colors.amber),
                              ),
                              dropdownColor: Colors.black,
                              style: TextStyle(color: Colors.amber),
                              value: selectedItem,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedItem = newValue;
                                });
                              },
                              items: currencyKeys.map<DropdownMenuItem<String>>((dynamic key) {
                                return DropdownMenuItem<String>(
                                  value: key,
                                  child: Text(
                                    currencies![key]["name"],
                                    style: TextStyle(color: Colors.amber),
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(width: 20),
                            DropdownButton<String>(
                              hint: Text(
                                'Escolha uma moeda',
                                style: TextStyle(color: Colors.amber),
                              ),
                              dropdownColor: Colors.black,
                              style: TextStyle(color: Colors.amber),
                              value: selectedItem2,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedItem2 = newValue;
                                });
                              },
                              items: currencyKeys.map<DropdownMenuItem<String>>((dynamic key) {
                                return DropdownMenuItem<String>(
                                  value: key,
                                  child: Text(
                                    currencies![key]["name"],
                                    style: TextStyle(color: Colors.amber),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                style: TextStyle(color: Colors.amber),
                                decoration: InputDecoration(
                                  labelText: "Valor",
                                  labelStyle: TextStyle(color: Colors.amber),
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                
                              ),
                            ),
                            SizedBox(width:  10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                fixedSize: Size(double.infinity, 56),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))
                              ),
                              onPressed: () {
                                setState(() {
                                  result = conversao(currencies![selectedItem2!]["buy"], inputValue);
                                });
                              }, 
                              child: Icon(Icons.money, color: Colors.white, size: 45,)
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        if (selectedItem != null && selectedItem2 != null)
                          
                          Text(
                            "$inputValue $selectedItem = $result $selectedItem2",
                            style: TextStyle(color: Colors.amber, fontSize: 20),
                          ),
                      ],
                    ),
                  );
                }
              default:
                return Container();
            }
          }),
    );
  }
}
//conversor de Moedas - parte 3.txt
//Exibindo conversor de Moedas - parte 3.txt…