import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/routes/app_route.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('Profile Screen'),
              ElevatedButton(
                onPressed: () => context.router.push(UpdateProfileRoute()),
                child: Text('go to Update Profile screen'),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => context.router.push(ResetPasswordRoute()),
                child: Text('go to Reset Password screen'),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => context.router.push(HistoryRoute()),
                child: Text('go to History screen'),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => context.router.push(FavoriteRoute()),
                child: Text('go to Favorite screen'),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => context.router.push(HelpCenterRoute()),
                child: Text('go to Help Center screen'),
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
