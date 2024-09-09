import 'package:flutter/material.dart';
import '../models/categorys.dart';
class CategoryMealsScreens extends StatelessWidget {
  const CategoryMealsScreens(this.category, {super.key});
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: Center(
        child: Text('Receitas por categorias ${category.id}'),
      ),
    );
  }
}