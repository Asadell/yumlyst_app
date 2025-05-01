import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/routes/app_route.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('Main Screen'),
              ElevatedButton(
                onPressed: () => context.router.push(HomeRoute()),
                child: Text('go to Home screen'),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => context.router.push(CameraRoute()),
                child: Text('go to Camera screen'),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => context.router.push(ProfileRoute()),
                child: Text('go to Profile screen'),
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
