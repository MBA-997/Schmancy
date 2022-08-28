import 'package:flutter/material.dart';

import 'screens/filters_screen.dart';
import 'screens/tabs_screen.dart';
import 'screens/meal_details_screen.dart';
import 'screens/category_meals_screen.dart';
import 'screens/categories_screen.dart';

import './models/meal.dart';
import 'dummy_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] == true && !meal.isGlutenFree) return false;
        if (_filters['lactose'] == true && !meal.isLactoseFree) return false;
        if (_filters['vegetarian'] == true && !meal.isVegetarian) return false;
        if (_filters['vegan'] == true && !meal.isVegan) return false;
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool _isFavorite(mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schmancy',
      theme: ThemeData(
        backgroundColor: Colors.white,
        primarySwatch: Colors.pink,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.pink),
        colorScheme: ColorScheme.fromSwatch(
            accentColor: const Color.fromARGB(255, 216, 216, 216)),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
      ),
      // fontFamily: 'Raleway',
      // textTheme: ThemeData.light().textTheme.copyWith(
      //     bodyText1: const TextStyle(
      //       color: Color.fromRGBO(20, 51, 51, 1),
      //     ),
      //     bodyText2: const TextStyle(
      //       color: Color.fromRGBO(20, 51, 51, 1),
      //     ),
      //     titleSmall: const TextStyle(
      //         fontSize: 20,
      //         // fontFamily: 'RobotoCondensed',
      //         fontWeight: FontWeight.bold))
      //         ),
      routes: {
        '/': (ctx) => TabsScreen(favoriteMeals: _favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(availableMeals: _availableMeals),
        MealDetailsScreen.routeName: (ctx) => MealDetailsScreen(
            toggleFavorite: _toggleFavorite, isFavorite: _isFavorite),
        FiltersScreen.routeName: (ctx) =>
            FiltersScreen(currentFilters: _filters, saveFilters: _setFilters),
      },
      onGenerateRoute: (settings) {
        return;
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      },
    );
  }
}
