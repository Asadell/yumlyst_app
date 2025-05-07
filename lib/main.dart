import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/core/network/dio_client.dart';
import 'package:recipe_app/core/storage/secure_storage.dart';
import 'package:recipe_app/features/auth/data/provider/auth_provider.dart';
import 'package:recipe_app/features/auth/data/repositories/auth_repository.dart';
import 'package:recipe_app/features/auth/data/services/auth_service.dart';
import 'package:recipe_app/features/category/data/provider/category_list_provider.dart';
import 'package:recipe_app/features/category/data/repositories/category_list_repository.dart';
import 'package:recipe_app/features/category/data/services/category_list_service.dart';
import 'package:recipe_app/features/home/data/provider/recipe_group_provider.dart';
import 'package:recipe_app/features/home/data/repositories/recipe_group_respository.dart';
import 'package:recipe_app/features/home/data/services/recipe_group_service.dart';
import 'package:recipe_app/routes/app_route.dart';
import 'package:recipe_app/style/theme/recipe_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // Core Services
        Provider<SecureStorageService>(
          create: (_) => SecureStorageService(),
        ),
        Provider<DioClient>(
          create: (context) => DioClient(context.read<SecureStorageService>()),
        ),
        Provider<Dio>(
          create: (context) => context.read<DioClient>().dio,
        ),

        // Auth Feature
        Provider<AuthService>(
          create: (context) => AuthService(
            context.read<Dio>(),
            context.read<SecureStorageService>(),
          ),
        ),
        Provider<AuthRepository>(
          create: (context) => AuthRepository(
            context.read<AuthService>(),
          ),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(
            context.read<AuthRepository>(),
          ),
        ),

        // Category Feature
        Provider<CategoryListService>(
          create: (context) => CategoryListService(
            context.read<Dio>(),
          ),
        ),
        Provider<CategoryRepository>(
          create: (context) => CategoryRepository(
            context.read<CategoryListService>(),
          ),
        ),
        ChangeNotifierProvider<CategoryListProvider>(
          create: (context) => CategoryListProvider(
            context.read<CategoryRepository>(),
          ),
        ),

        // Recipe Feature
        Provider<RecipeGroupService>(
          create: (context) => RecipeGroupService(
            context.read<Dio>(),
          ),
        ),
        Provider<RecipeRepository>(
          create: (context) => RecipeRepository(
            context.read<RecipeGroupService>(),
          ),
        ),
        ChangeNotifierProvider<RecipeGroupProvider>(
          create: (context) => RecipeGroupProvider(
            context.read<RecipeRepository>(),
          ),
        ),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Recipe App Aibeecara',
      theme: RecipeTheme.lightTheme,
      routerConfig: _appRouter.config(),
    );
  }
}
