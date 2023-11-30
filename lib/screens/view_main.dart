import 'package:flutter/material.dart';
import 'package:spoonacular_app/screens/recipe_search.dart';

class ViewMain extends StatelessWidget {
  const ViewMain({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'to Recipe App',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.network(
              'https://pbs.twimg.com/profile_images/344513261581896983/2b388c65555cce57ddbd31a2284d4676_400x400.png',
              height: 150,
              width: 150,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RecipeSearch()));
              },
              child: const Text('Get Started'),
            ),
          ],
        ),
      )
    );
  }
}