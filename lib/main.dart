import 'package:flutter/material.dart';
import 'package:recipe_app/routes/app_route.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Recipe App Aibeecara',
      routerConfig: _appRouter.config(),
    );
  }
}
