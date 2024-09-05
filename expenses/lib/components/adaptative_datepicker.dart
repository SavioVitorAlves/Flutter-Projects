import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class AdaptativeDatepicker extends StatelessWidget {
  const AdaptativeDatepicker({required this.onDateChanged, required this.selectedDate ,super.key});
  
  final DateTime selectedDate;
  final Function (DateTime) onDateChanged; 
  
  _showDatePicker(BuildContext context){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    ).then((pickedDate){
      if (pickedDate == null) {
        return;
      }
      onDateChanged(pickedDate);
      
    });
  }
  @override
  Widget build(BuildContext context) {
    
    

    
    return Platform.isIOS ? Container(
      height: 180,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.date,
        initialDateTime: DateTime.now(),
        minimumDate: DateTime(2024),
        maximumDate: DateTime.now(), 
        onDateTimeChanged: onDateChanged,
      ),
    )
    : Container(
                      height: 70,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              selectedDate == null ? 'Nenhuma data selecionada!'
                              : 'Data Selecionada: ${DateFormat('dd/MM/y').format(selectedDate)}',
                            ),
                          ),
                          TextButton(
                            onPressed: () => _showDatePicker(context),
                            child: Text(
                              'Selecionar Data',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary
                              ),
                            ),
                            
                          ),
                        ],
                      ),
                    ); 
  }
}