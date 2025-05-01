import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/routes/app_route.dart';

@RoutePage()
class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('Food Detail Screen'),
              ElevatedButton(
                onPressed: () => context.router.push(InstructionRoute()),
                child: Text('go to Instruction screen'),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => context.router.push(AboutRoute()),
                child: Text('go to About screen'),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => context.router.push(ReviewRoute()),
                child: Text('go to Reviews screen'),
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
