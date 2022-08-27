import 'package:flutter/material.dart';
import './screens/tabs_screen.dart';

import './screens/meal_details_screen.dart';
import 'screens/category_meals_screen.dart';
import 'screens/categories_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schmancy',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        appBarTheme: AppBarTheme(backgroundColor: Colors.pink),
        colorScheme: ColorScheme.fromSwatch(
            accentColor: const Color.fromARGB(126, 255, 255, 255)),
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
        '/': (ctx) => const TabsScreen(),
        CategoryMealsScreen.routeName: (ctx) => const CategoryMealsScreen(),
        MealDetailsScreen.routeName: (ctx) => const MealDetailsScreen(),
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
