import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/features/food/views/food_detail_screen.dart';
import 'package:recipe_app/routes/app_route.dart';
import 'package:recipe_app/style/colors/recipe_colors.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                _buildSearchBar(),
                _buildCategories(),
                _buildDinnerRecommendations(),
                _buildHealthyLifestyleChoices(),
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
          const Text(
            'Good evening, kyiweza',
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

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: RecipeColors.neutral300.color),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for recipes',
          prefixIcon: Icon(Icons.search, color: RecipeColors.neutral500.color),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    final categories = [
      'Rice',
      'Meats',
      'Traditionals',
      'Snacks',
      'Vegetables'
    ];
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
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(right: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: RecipeColors.neutral100.color,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: GestureDetector(
                  onTap: () => context.router
                      .push(CategoryRoute(category: categories[index])),
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      color: RecipeColors.neutral700.color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDinnerRecommendations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Dinner time! ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Image.asset('assets/images/loading_cover.jpg',
                width: 20, height: 20),
            Image.asset('assets/images/loading_cover.jpg',
                width: 20, height: 20),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Check out these recommendations!',
          style: TextStyle(
            fontSize: 14,
            color: RecipeColors.neutral600.color,
          ),
        ),
        const SizedBox(height: 16),
        _buildFoodGrid([
          _FoodItem(
            name: 'Semur Bola Daging',
            image: 'assets/images/loading_cover.jpg',
            rating: 4.8,
            timeInMinutes: 40,
            tag: 'Best',
          ),
          _FoodItem(
            name: 'Bebek Goreng Sambal',
            image: 'assets/images/loading_cover.jpg',
            rating: 5.0,
            timeInMinutes: 35,
            tag: null,
          ),
        ]),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildHealthyLifestyleChoices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Healthy Lifestyle Choices ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Image.asset('assets/images/loading_cover.jpg',
                width: 20, height: 20),
          ],
        ),
        const SizedBox(height: 16),
        _buildFoodGrid([
          _FoodItem(
            name: 'Salad Halibut',
            image: 'assets/images/loading_cover.jpg',
            rating: 4.8,
            timeInMinutes: 25,
            tag: 'New',
          ),
          _FoodItem(
            name: 'Sayur Asem',
            image: 'assets/images/loading_cover.jpg',
            rating: 5.0,
            timeInMinutes: 30,
            tag: null,
          ),
        ]),
      ],
    );
  }

  Widget _buildFoodGrid(List<_FoodItem> items) {
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
        final food = items[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FoodDetailScreen(),
              ),
            );
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      food.image,
                      width: double.infinity,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                    if (food.tag != null)
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          color: RecipeColors.primary700.color,
                          child: Text(
                            food.tag!,
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
                        food.name,
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
                            food.rating.toString(),
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
                            '${food.timeInMinutes} min',
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

class _FoodItem {
  final String name;
  final String image;
  final double rating;
  final int timeInMinutes;
  final String? tag;

  _FoodItem({
    required this.name,
    required this.image,
    required this.rating,
    required this.timeInMinutes,
    this.tag,
  });
}
