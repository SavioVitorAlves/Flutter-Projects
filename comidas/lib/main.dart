import 'screens/settings_screens.dart';
import 'package:flutter/material.dart';
import './screens/category_meals_screens.dart';
import 'screens/meal_detail_screem.dart';
import './utils/app_routes.dart';
import 'screens/tabs_screens.dart';
import './models/meals.dart';
import './data/dummy_data.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  List<Meal> _availableMeals = DUMMY_MEALS;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
        ).copyWith(
          secondary: Colors.amber,
        ),
        fontFamily: 'Raleway',
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
          titleLarge: const TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
          ),
        ),
      ),
      routes: {
        AppRoutes.HOME: (ctx) => const TabsScreens(),
        AppRoutes.CATEGORY_MEALS:(ctx) => CategoryMealsScreens(_availableMeals),
        AppRoutes.MEALS_DETAIL:(ctx) => const MealDetailScreem(),
        AppRoutes.SETTINGS:(ctx) => const SettingsScreens(),
      },
    );
  }
}
