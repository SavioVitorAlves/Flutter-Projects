import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'category_screens.dart';
import 'favorit_screens.dart';
import '../components/main_drawer.dart';
import '../models/meals.dart';
class TabsScreens extends StatefulWidget {
  const TabsScreens(this.favoritMelas, {super.key});
  
  final List<Meal> favoritMelas;
  @override
  State<TabsScreens> createState() => _TabsScreensState();
}

class _TabsScreensState extends State<TabsScreens> {
  int _selectedScreensIndex = 0;
  late List<Map<String, Object>> _screens;
  @override
  void initState(){
    super.initState();
    _screens = [
      {'title': 'Lista de Categorias', 'screen': CategoryScreens()},
      {'title': 'Meus Favoritos', 'screen': FavoritScreens(widget.favoritMelas)}    
    ];
  }

  _selectdScreens(int index){
    setState(() {
      _selectedScreensIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          _screens[_selectedScreensIndex]['title'] as String
        ),
      ),
      drawer: MainDrawer(),
      body: _screens[_selectedScreensIndex]['screen'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectdScreens,
        backgroundColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectedScreensIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.category,),label: 'Categorias'),
          BottomNavigationBarItem(icon: Icon(Icons.star,),label: 'Favoritos')
        ]
      ),
      );
  }
}