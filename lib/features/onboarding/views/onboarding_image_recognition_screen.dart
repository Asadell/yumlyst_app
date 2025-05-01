import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/routes/app_route.dart';

@RoutePage()
class OnboardingImageRecognitionScreen extends StatelessWidget {
  const OnboardingImageRecognitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('Onboarding Image Recognition Screen'),
              ElevatedButton(
                onPressed: () => context.router.push(LoginRoute()),
                child: Text('go to .. screen'),
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
