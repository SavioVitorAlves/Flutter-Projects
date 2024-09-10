import 'package:flutter/material.dart';
import '../models/categorys.dart';
import '../data/dummy_data.dart';
import '../components/meal_item.dart';
class CategoryMealsScreens extends StatelessWidget {
  CategoryMealsScreens({super.key});
  
  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)?.settings.arguments as Category;
    final categoryMeals = DUMMY_MEALS.where((meal){
      return meal.categories.contains(category.id);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: (ctx, index){
          return MealItem(categoryMeals[index]);
        }
      ),
    );
  }
}