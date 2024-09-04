import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';
import 'components/chart.dart';
import 'components/transacton_dart.dart';
import '../models/transection.dart';
import 'dart:math';


void main(){
  runApp(ExpensesApp());
}
class ExpensesApp extends StatelessWidget {
  ExpensesApp({super.key});
  final ThemeData tema = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage(),
      theme: tema.copyWith(
      
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        textTheme: tema.textTheme.copyWith(
          titleLarge:const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  //LISTA DE TRANSAÇÕES
    final List<Transacoes> _transacoes = [
    //Transacoes(id: 't1', title: 'conta de agua', value: 45.30, date: DateTime.now().subtract(Duration(days: 3))),
    //Transacoes(id: 't2', title: 'conta de luz', value: 145.50, date: DateTime.now().subtract(Duration(days: 4)))
  ];
  List<Transacoes> get _recentTransations{
    return _transacoes.where((tr){
      return tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }
  
  _addTransation(String title, double value, DateTime date){
    final newTransation = Transacoes(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );
    setState(() {
      _transacoes.add(newTransation);
    });
    Navigator.of(context).pop();
  } 

  _removeTransecion(String id){
    setState(() {
      _transacoes.removeWhere((tr){
        return tr.id == id;
      });
    });
  }

  _opemTransactionFormModal(BuildContext context){
    showModalBottomSheet(
      context: context,
      builder: (_){
        return TransactionForm(_addTransation);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Despessas Pessoais'),
        actions: [
          IconButton(
            onPressed: ()=>_opemTransactionFormModal(context), 
            icon: const Icon(Icons.add), 
            color: Colors.white,)
        ],
      );

    final availableHeight = MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top;
    
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //CHAMA O WIDGET DO GRAFICO
            Container(
              child: Chart(_recentTransations),
              height: availableHeight * 0.3,  
            ),
            //INSTANCIA O WIDGET PRINCIPAL
            Container(
              child: TransactionList(_transacoes, _removeTransecion),
              height: availableHeight * 0.7,
            ),
          
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed:()=>_opemTransactionFormModal(context), 
        child: const Icon(Icons.add),
      ), 
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}