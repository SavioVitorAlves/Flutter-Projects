import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../components/catergory_item.dart';
class CategoryScreens extends StatelessWidget {
  const CategoryScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vamos cozinhar?'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3/2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20
        ),
        children: DUMMY_CATEGORIES.map((cat){
          return CatergoryItem(cat);
        }).toList(),
      ),
    );
  }
}