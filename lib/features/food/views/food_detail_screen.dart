import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/style/colors/recipe_colors.dart';

@RoutePage()
class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFoodTitle(),
                  const SizedBox(height: 16),
                  _buildInfoBar(),
                  const SizedBox(height: 24),
                  _buildDescription(),
                  const SizedBox(height: 24),
                  _buildIngredients(),
                  const SizedBox(height: 24),
                  _buildInstructions(),
                  const SizedBox(height: 24),
                  _buildOrderButton(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Image.asset(
              'assets/images/loading_cover.jpg',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.5),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: RecipeColors.white.color.withOpacity(0.7),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_back,
            color: RecipeColors.neutral900.color,
          ),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: RecipeColors.white.color.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.favorite_border,
              color: RecipeColors.neutral900.color,
            ),
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: RecipeColors.white.color.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.share,
              color: RecipeColors.neutral900.color,
            ),
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildFoodTitle() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Beef Rendang',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Traditional Indonesian beef dish',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildInfoItem(Icons.star, '4.9', 'Rating'),
        _buildInfoItem(Icons.access_time, '90 min', 'Cooking'),
        _buildInfoItem(Icons.local_fire_department, '485', 'Calories'),
        _buildInfoItem(Icons.people, '4', 'Servings'),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: RecipeColors.primary700.color),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: RecipeColors.neutral500.color,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Beef Rendang is a rich and tender coconut beef stew which is explosively flavorful and incredibly tender. It\'s a signature dish from Indonesia, especially popular in Padang cuisine, and is often served at special occasions.',
          style: TextStyle(
            color: RecipeColors.neutral700.color,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildIngredients() {
    final ingredients = [
      '800g beef chuck, cut into 4cm cubes',
      '400ml coconut milk',
      '3 tablespoons rendang paste',
      '2 lemongrass stalks, bruised',
      '4 kaffir lime leaves',
      '2 bay leaves',
      '1 cinnamon stick',
      '1 tablespoon palm sugar',
      'Salt to taste',
      'Cooking oil'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ingredients',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: ingredients.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: RecipeColors.primary700.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      ingredients[index],
                      style: TextStyle(
                        color: RecipeColors.neutral700.color,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildInstructions() {
    final steps = [
      'Heat oil in a large pot over medium heat.',
      'Add the rendang paste and stir for 2-3 minutes until fragrant.',
      'Add the beef cubes and stir to coat with the paste.',
      'Pour in the coconut milk and add lemongrass, lime leaves, bay leaves, and cinnamon.',
      'Bring to a boil, then reduce heat to low and simmer uncovered.',
      'Cook for about 2 hours, stirring occasionally to prevent sticking.',
      'When the sauce has thickened and darkened, add palm sugar and salt.',
      'Continue cooking until the meat is tender and the sauce has mostly been absorbed.',
      'Remove from heat and let rest for 15 minutes before serving.'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cooking Instructions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: steps.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: RecipeColors.primary700.color,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: RecipeColors.white.color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      steps[index],
                      style: TextStyle(
                        color: RecipeColors.neutral700.color,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildOrderButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Order Ingredients',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
