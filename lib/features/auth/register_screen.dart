import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('Register Screen'),
              ElevatedButton(
                onPressed: () => context.router.pop(),
                child: Text('back to login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
