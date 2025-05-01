import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/core/storage/secure_storage.dart';
import 'package:recipe_app/routes/app_route.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final token = SecureStorageService().getToken();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('Main Screen'),
              // cek token
              Center(
                child: FutureBuilder<String?>(
                  future: SecureStorageService().getToken(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasData && snapshot.data != null) {
                      return Text('Token: ${snapshot.data}');
                    } else {
                      return const Text('No token found');
                    }
                  },
                ),
              ),
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
