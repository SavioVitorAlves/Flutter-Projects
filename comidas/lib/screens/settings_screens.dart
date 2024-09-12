import '../models/settings.dart';
import 'package:flutter/material.dart';
import '../components/main_drawer.dart';
class SettingsScreens extends StatefulWidget {
  const SettingsScreens({super.key});

  @override
  State<SettingsScreens> createState() => _SettingsScreensState();
}

class _SettingsScreensState extends State<SettingsScreens> {
  
  var settings = Settings();
  
  Widget _createSwitch(String title, String subtitle, bool value, Function onChanged){
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
       onChanged: onChanged(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Configurações',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _createSwitch(
                  'Sem Glutm', 
                  'Só exibe refeições sem glutem', 
                  settings.isGlutenFree, 
                  (value) => setState(() => settings.isGlutenFree = value)
                ),
                _createSwitch(
                  'Sem Lactose', 
                  'Só exibe refeições sem lactose', 
                  settings.isGlutenFree, 
                  (value) => setState(() => settings.isLactoseFree = value)
                ),
                _createSwitch(
                  'Vegana', 
                  'Só exibe refeições veganas', 
                  settings.isVegan, 
                  (value) => setState(() => settings.isVegan = value)
                ),
                _createSwitch(
                  ' Vegetariana', 
                  'Só exibe refeições Vegetariana', 
                  settings.isVegetarian, 
                  (value) => setState(() => settings.isVegetarian = value)
                ),
              ],
            )
          )
        ],
      )
    );
  }
}