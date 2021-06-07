import 'package:flutter/material.dart';
import 'package:mealapp/dummy_data.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/screens/category_meals_screen.dart';
import 'package:mealapp/screens/filters_screen.dart';
import 'package:mealapp/screens/meal_detail_screen.dart';
import 'package:mealapp/screens/tabs_screen.dart';

import './screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

  List<Meal> _availableMeals=DUMMY_MEALS;
  List<Meal> _favoriteMeals=[];

  Map<String,bool> _filters = {
    'gluten' : false,
    'lactose' : false,
    'vegan' : false,
    'vegetarian' : false,

  };

  void toggleFavorites(String mealId)
  {
     final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);

     if (existingIndex >=0)
       {
         setState(() {
           _favoriteMeals.removeAt(existingIndex);
         });
       }else
         {
           setState(() {
             _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
           });
         }
  }

  bool _isMealFavorites(String id)
  {
     return _favoriteMeals.any((meal) => meal.id == id);
  }

  void _setFilters(Map<String,bool> _filterData)
  {
    setState(() {
      _filters = _filterData;
          _availableMeals = DUMMY_MEALS.where((meal) {
            if  ( _filters['gluten'] && !meal.isGlutenFree)
            {
              return false;
            }
            if  ( _filters['lactose'] && !meal.isLactoseFree)
            {
              return false;
            }
            if  ( _filters['vegan'] && !meal.isVegan)
            {
              return false;
            }
            if  ( _filters['vegetarian'] && !meal.isVegetarian)
            {
              return false;
            }
            return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          textTheme: ThemeData
              .light()
              .textTheme
              .copyWith(
              body1: TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 1)
              ),
              body2: TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 1)
              ),
              title: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold
              )
          )
      ),
    //  home: MyHomePage(),
     // home: CategoriesScreen(),
      routes: {
        '/': (context) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName : (context) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName : (context) => MealDetailScreen(toggleFavorites,_isMealFavorites),
        FiltersScreen.routeName : (context) => FiltersScreen(_filters,_setFilters),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Meal App'),
        ),
        body: CategoriesScreen()
    );
  }
}
