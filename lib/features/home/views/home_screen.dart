import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/features/food/views/food_detail_screen.dart';
import 'package:recipe_app/routes/app_route.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('Home Screen'),
              ElevatedButton(
                onPressed: () => context.router.push(SearchRoute()),
                child: Text('go to Search screen'),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => context.router.push(CategoryRoute()),
                child: Text('go to Category screen'),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => context.router.push(FoodDetailRoute()),
                child: Text('go to Food Detail screen'),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () => context.router.pop(),
                child: Text('back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
