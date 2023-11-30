
import 'package:flutter/material.dart';
import 'package:spoonacular_app/screens/recipe_search.dart';
import 'package:spoonacular_app/screens/view_main.dart';
import 'package:spoonacular_app/widgets/favorite_recipe.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const ViewMain(),
    const RecipeSearch(),
    const FavoriteRecipes(),
  ];

  _changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        leading: Image.network("https://pbs.twimg.com/profile_images/344513261581896983/2b388c65555cce57ddbd31a2284d4676_400x400.png"),
        title: const Text("Spoonacular"),
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => _changeTab(index),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}