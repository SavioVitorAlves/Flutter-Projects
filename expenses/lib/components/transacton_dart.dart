import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/transection.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this.transection, this.onRemove, {super.key});
  //LISTA Q INSTANCIA A CLASS E O CONSTRUTOR DA LISTA
  final List<Transacoes> transection;
  final void Function(String) onRemove;
  /*ESSE WIDGET LISTA TODAS AS INFORMAÇÕES Q TEM DENTRO DA LISTA E
  ADICIONA CADA CONJUNTO DE DADOS DENTRO DE UM CARD*/

  @override
  Widget build(BuildContext context) {
    return transection.isEmpty ? LayoutBuilder(builder: (context, constraints){
      return Column(
        children: <Widget>[
          const SizedBox(height: 20),
          const Text(
            'Nenhuma Transação',
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: constraints.maxHeight * 0.6,
            child: Image.asset('./assets/imgs/waiting.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      );
    })
    : ListView.builder(
      itemCount: transection.length,
      itemBuilder: (ctx, index){
        final tr = transection[index];
        return Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 8,
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: FittedBox(
                  child: Text('R\$${tr.value}')
                ),
              ),
            ),
            title: Text(
              tr.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            subtitle: Text(
              DateFormat('d MMM y').format(tr.date),
            ),
            trailing: MediaQuery.of(context).size.width > 480 ?
            TextButton.icon(
              onPressed: () => onRemove(tr.id),
              icon: const Icon(Icons.delete),
              label: Text('Excluir',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ) :
            IconButton(
              onPressed: () => onRemove(tr.id), 
              icon: const Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        );
            },
          );
  }
}