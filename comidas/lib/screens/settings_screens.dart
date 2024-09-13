import '../models/settings.dart';
import 'package:flutter/material.dart';
import '../components/main_drawer.dart';
class SettingsScreens extends StatefulWidget {
  const SettingsScreens(this.settings, this.onSettingsChanged, {super.key});
  final Function(Settings) onSettingsChanged;
  final Settings settings;


  @override
  State<SettingsScreens> createState() => _SettingsScreensState();
}

class _SettingsScreensState extends State<SettingsScreens> {
  
 Settings? settings;

 void initState(){
  super.initState();
  settings = widget.settings;
 }
  
  Widget _createSwitch(String title, String subtitle, bool value, Function(bool) onChanged){
    return SwitchListTile.adaptive(
      inactiveThumbColor: Theme.of(context).colorScheme.secondary,
      inactiveTrackColor: const Color.fromARGB(255, 228, 227, 227),
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
       onChanged: (value){
        onChanged(value);
        widget.onSettingsChanged(settings!);
      },
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
                  'Sem Glutem', 
                  'Só exibe refeições sem glutem', 
                  settings!.isGlutenFree, 
                  (value) => setState(() => settings!.isGlutenFree = value)
                ),
                _createSwitch(
                  'Sem Lactose', 
                  'Só exibe refeições sem lactose', 
                  settings!.isLactoseFree, 
                  (value) => setState(() => settings!.isLactoseFree = value)
                ),
                _createSwitch(
                  'Vegana', 
                  'Só exibe refeições veganas', 
                  settings!.isVegan, 
                  (value) => setState(() => settings!.isVegan = value)
                ),
                _createSwitch(
                  ' Vegetariana', 
                  'Só exibe refeições Vegetariana', 
                  settings!.isVegetarian, 
                  (value) => setState(() => settings!.isVegetarian = value)
                ),
               
              ],
            )
          )
        ],
      )
    );
  }
}