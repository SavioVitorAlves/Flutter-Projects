import 'package:flutter/material.dart';
import '../models/meals.dart';
import '../components/meal_item.dart';
class FavoritScreens extends StatelessWidget {
  const FavoritScreens(this.favoritMelas, {super.key});
  final List<Meal> favoritMelas;
  @override
  Widget build(BuildContext context) {
    if (favoritMelas.isEmpty) {
      return Center(
        child: Text('Nenhuma refeição foi marcada como favorita!'),
      );  
    }else{
      return ListView.builder(
        itemCount: favoritMelas.length,
        itemBuilder: (context, index) {
          return MealItem(favoritMelas[index]);
        } ,
      );
    }
    
  }
}