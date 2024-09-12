import '../models/meals.dart';
import 'package:flutter/material.dart';
import '../models/categorys.dart';
import '../data/dummy_data.dart';
import '../components/meal_item.dart';
class CategoryMealsScreens extends StatelessWidget {
  CategoryMealsScreens(this.meals, {super.key});
  final List<Meal> meals;
  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)?.settings.arguments as Category;
    final categoryMeals = meals.where((meal){
      return meal.categories.contains(category.id);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
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