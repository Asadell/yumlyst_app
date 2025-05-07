import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/core/widgets/loading_indicator.dart';
import 'package:recipe_app/features/auth/data/provider/auth_provider.dart';
import 'package:recipe_app/features/category/data/provider/category_list_provider.dart';
import 'package:recipe_app/features/category/data/static/category_list_result_state.dart';
import 'package:recipe_app/features/food/data/models/recipe.dart';
import 'package:recipe_app/features/food/views/recipe_detail_screen.dart';
import 'package:recipe_app/features/home/data/models/recipe_group.dart';
import 'package:recipe_app/features/home/data/provider/recipe_group_provider.dart';
import 'package:recipe_app/routes/app_route.dart';
import 'package:recipe_app/style/colors/recipe_colors.dart';
import 'package:recipe_app/features/home/data/static/recipe_group_list_result_state.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load data when screen initializes
    Future.microtask(() {
      context.read<CategoryListProvider>().loadCategories();
      context.read<RecipeGroupProvider>().loadHomeRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                _buildCategories(),
                _buildRecipeGroups(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Text(
            'Good evening, ${context.watch<AuthProvider>().identifier ?? 'Guest'}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.router.push(SearchRoute()),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Categories',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 36,
          child: Consumer<CategoryListProvider>(
            builder: (context, provider, child) {
              return switch (provider.resultState) {
                CategoryListLoadingState() => const Center(
                    child: LoadingIndicator(),
                  ),
                CategoryListLoadedState(data: var categories) =>
                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: RecipeColors.neutral100.color,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: GestureDetector(
                          onTap: () => context.router
                              .push(CategoryRoute(category: category.name)),
                          child: Text(
                            category.name,
                            style: TextStyle(
                              color: RecipeColors.neutral700.color,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                CategoryListErrorState(error: var message) => Center(
                    child: Text('Error: $message'),
                  ),
                _ => const SizedBox(),
              };
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildRecipeGroups() {
    return Consumer<RecipeGroupProvider>(
      builder: (context, provider, child) {
        return switch (provider.resultState) {
          RecipeGroupListLoadingState() => const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: LoadingIndicator(),
              ),
            ),
          RecipeGroupListLoadedState(data: var recipeGroups) => Column(
              children: recipeGroups
                  .map((group) => _buildRecipeGroup(group))
                  .toList(),
            ),
          RecipeGroupListErrorState(error: var message) => Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Error: $message'),
              ),
            ),
          _ => const SizedBox(),
        };
      },
    );
  }

  Widget _buildRecipeGroup(RecipeGroup group) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              group.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 5),
            if (group.title.contains('Dinner')) ...[
              Image.asset('assets/images/loading_cover.jpg',
                  width: 20, height: 20),
              Image.asset('assets/images/loading_cover.jpg',
                  width: 20, height: 20),
            ] else if (group.title.contains('Healthy'))
              Image.asset('assets/images/loading_cover.jpg',
                  width: 20, height: 20),
          ],
        ),
        if (group.subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            group.subtitle!,
            style: TextStyle(
              fontSize: 14,
              color: RecipeColors.neutral600.color,
            ),
          ),
        ],
        const SizedBox(height: 16),
        _buildFoodGrid(group.recipes),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildFoodGrid(List<Recipe> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final recipe = items[index];
        final String? tag = recipe.difficulty == Difficulty.EASY
            ? 'Easy'
            : (recipe.isFavorite ? 'Best' : null);

        return GestureDetector(
          onTap: () =>
              context.router.push(RecipeDetailRoute(recipeId: recipe.recipeId)),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.network(
                      recipe.image,
                      width: double.infinity,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        'assets/images/loading_cover.jpg',
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (tag != null)
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          color: RecipeColors.primary700.color,
                          child: Text(
                            tag,
                            style: TextStyle(
                              color: RecipeColors.white.color,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: RecipeColors.gold700.color,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            recipe.rating.toString(),
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: RecipeColors.neutral500.color,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${recipe.estimationTime} min',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
