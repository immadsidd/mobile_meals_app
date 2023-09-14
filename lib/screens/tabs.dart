import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/category.dart';
import 'package:meals_app/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {

  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  void _SelectPage(int index){
    setState(() {
      _selectedPageIndex = index;
    });

  }
   void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      
    } else {
      setState(() {
        _favoriteMeals.add(meal);
       
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    Widget activePage = Categories(onToggleFavorite: _toggleMealFavoriteStatus,);
    var activePageTitle= 'Categories';

    if(_selectedPageIndex == 1){
      activePage = MealsScreen(meals: _favoriteMeals,  onToggleFavorite: _toggleMealFavoriteStatus,);
      activePageTitle= 'your favourites';

    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _SelectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label:'categories' ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label:'favorites' ),
        ],
      ),
    );
  }
}
