import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/routes/app_route.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('Splash Screen'),
              ElevatedButton(
                onPressed: () =>
                    context.router.push(OnboardingCookGuidanceRoute()),
                child: Text('go to .. screen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
