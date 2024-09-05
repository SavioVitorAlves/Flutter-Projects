import 'package:flutter/material.dart';
import 'adaptative_datepicker.dart';
import 'adaptative_button.dart';
import 'adaptative_textfield.dart';
class TransactionForm extends StatefulWidget {
  
  
  final void Function(String, double, DateTime) onSubmit;
  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  
  final _titleControler = TextEditingController();
  final _valueControler = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm(){
    final title = _titleControler.text;
    final value = double.tryParse(_valueControler.text) ?? 0.0;
    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate);
  }

  
  /*CRIA O FOMAULARIO DE ADICIONAR NOVAS TRANSAÇÕES*/
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: 10 + MediaQuery.of(context).viewInsets.bottom
                ),
                child: Column(
                  children: <Widget>[
                    AdaptativeTextfield(
                      controller: _titleControler,
                      onSubmitted: (_) => _submitForm(),
                      label: 'Titulo',
                    ),
                    AdaptativeTextfield(
                      controller: _valueControler,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      onSubmitted: (_) => _submitForm(),
                      label: 'Valor (R\$)',
                    ),
                    AdaptativeDatepicker(
                      onDateChanged: (newDate){
                        setState(() {
                          _selectedDate = newDate;
                        });
                      },
                      selectedDate: _selectedDate
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AdaptativeButton(label:'Nova Transação', onPressed:  _submitForm),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}