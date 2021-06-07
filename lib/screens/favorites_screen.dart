import 'package:flutter/material.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  FavoritesScreen(this.favoriteMeals);
  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty)
      {
        return Center(
          child: Text("No favorite meals yet. try to add some!"),
        );
      }else
        {
          return ListView.builder(
            itemBuilder: (ctx, index) {
              return MealItem(
                id: favoriteMeals[index].id,
                imageUrl: favoriteMeals[index].imageUrl,
                title: favoriteMeals[index].title,
                duration: favoriteMeals[index].duration,
                complexity: favoriteMeals[index].complexity,
                affordability: favoriteMeals[index].affordability,
              //  removeItem: _removeMeal,
              );
            },
            itemCount: favoriteMeals.length,
          );
        }

  }
}
