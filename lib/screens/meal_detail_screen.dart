import 'package:flutter/material.dart';
import 'package:mealapp/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = "meal_detail";
  final Function toggleFavorites;
  final Function isMealFavorites;

  MealDetailScreen(this.toggleFavorites,this.isMealFavorites);

  Widget buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildSectionContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.pinkAccent),
            borderRadius: BorderRadius.circular(10)),
        height: 200,
        width: 350,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final mealData = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text(mealData.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                mealData.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildSectionContainer(ListView.builder(
              itemBuilder: (ctx, index) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Text(
                    mealData.ingredients[index],
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              itemCount: mealData.ingredients.length,
            )),
            buildSectionTitle(context, 'Steps'),
            buildSectionContainer(ListView.builder(
              itemBuilder: (ctx, index) => Column(children: [
                ListTile(
                  leading: CircleAvatar(child: Text('# ${index + 1}')),
                  title: Text(mealData.steps[index]),
                ),
                Divider()
              ]),
              itemCount: mealData.steps.length,
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {toggleFavorites(mealId);},
        child: Icon(
          isMealFavorites(mealId) ? Icons.favorite : Icons.favorite_border
        ),
      ),
    );
  }
}
