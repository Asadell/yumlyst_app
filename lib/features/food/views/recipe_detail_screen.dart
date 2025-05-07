import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/features/food/data/provider/recipe_detail_provider.dart';
import 'package:recipe_app/routes/app_route.dart';
import '../../../style/colors/recipe_colors.dart';
import '../data/models/recipe_detail.dart';
import 'package:recipe_app/features/food/data/static/recipe_detail_result_state.dart';

@RoutePage()
class RecipeDetailScreen extends StatefulWidget {
  final String recipeId;

  const RecipeDetailScreen({
    super.key,
    @PathParam('id') required this.recipeId,
  });

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    Future.microtask(() {
      context.read<RecipeDetailProvider>().getRecipeDetail(widget.recipeId);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RecipeColors.neutral50.color,
      body: SafeArea(
        child: Consumer<RecipeDetailProvider>(
          builder: (context, provider, child) {
            return switch (provider.state) {
              RecipeDetailLoadingState() => const Center(
                  child: CircularProgressIndicator(),
                ),
              RecipeDetailLoadedState(data: var recipe) =>
                _buildRecipeDetail(recipe, provider),
              RecipeDetailErrorState(message: var error) =>
                _buildErrorState(error),
              _ => const Center(
                  child: Text('No recipe details available'),
                ),
            };
          },
        ),
      ),
    );
  }

  Widget _buildErrorState(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          const Text(
            'Error loading recipe',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(errorMessage),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context
                  .read<RecipeDetailProvider>()
                  .getRecipeDetail(widget.recipeId);
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeDetail(
      RecipeDetail recipe, RecipeDetailProvider provider) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 220,
              width: double.infinity,
              color: Colors.black,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    recipe.video,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported, size: 64),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Playing video')),
                      );
                    },
                    child: Icon(
                      Icons.play_circle_fill,
                      color: Colors.white.withOpacity(0.8),
                      size: 64,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                '00:00',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '06:32',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 3,
                          color: Colors.grey.withOpacity(0.5),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child:
                            const Icon(Icons.arrow_back, color: Colors.black),
                      ),
                      onPressed: () => context.router.pop(),
                      tooltip: 'Back',
                    ),
                    if (recipe.name.length < 20)
                      Text(
                        recipe.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          shadows: [
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 3.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ],
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          recipe.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: recipe.isFavorite ? Colors.red : Colors.grey,
                        ),
                      ),
                      onPressed: () {},
                      tooltip: recipe.isFavorite
                          ? 'Remove from favorites'
                          : 'Add to favorites',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (recipe.name.length >= 20)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              recipe.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: RecipeColors.neutral800.color,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 2),
                blurRadius: 2,
              ),
            ],
          ),
          child: TabBar(
            controller: _tabController,
            labelColor: RecipeColors.primary700.color,
            unselectedLabelColor: RecipeColors.neutral500.color,
            indicatorColor: RecipeColors.primary700.color,
            tabs: const [
              Tab(text: 'Instructions'),
              Tab(text: 'About'),
              Tab(text: 'Reviews'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              InstructionsTabContent(recipe: recipe),
              AboutTabContent(recipe: recipe),
              ReviewsTabContent(recipe: recipe),
            ],
          ),
        ),
      ],
    );
  }
}

class InstructionsTabContent extends StatelessWidget {
  final RecipeDetail recipe;

  const InstructionsTabContent({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: RecipeColors.primary300.color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: RecipeColors.primary700.color,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Cooking Time: ${recipe.estimateTime}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: RecipeColors.primary700.color,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Icon(
                Icons.shopping_basket,
                color: RecipeColors.neutral800.color,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Ingredients',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: RecipeColors.neutral800.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 5,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: recipe.ingredients
                .map((ingredient) => IngredientItem(
                      text: ingredient,
                      color: RecipeColors.primary300.color,
                    ))
                .toList(),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Icon(
                Icons.build,
                color: RecipeColors.neutral800.color,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Tools',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: RecipeColors.neutral800.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 5,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: recipe.tools
                .map((tool) => IngredientItem(
                      text: tool,
                      color: RecipeColors.primary300.color,
                    ))
                .toList(),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Icon(
                Icons.format_list_numbered,
                color: RecipeColors.neutral800.color,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Steps',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: RecipeColors.neutral800.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...List.generate(recipe.steps.length, (index) {
            return StepItem(
              number: index + 1,
              text: recipe.steps[index],
            );
          }),
        ],
      ),
    );
  }
}

class AboutTabContent extends StatelessWidget {
  final RecipeDetail recipe;

  const AboutTabContent({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.star,
                color: RecipeColors.gold700.color,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Review Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: RecipeColors.neutral800.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '${recipe.averageRating}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: RecipeColors.primary700.color,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.star,
                            color: RecipeColors.gold700.color, size: 20),
                      ],
                    ),
                    Text(
                      'out of 5',
                      style: TextStyle(
                        fontSize: 12,
                        color: RecipeColors.neutral500.color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Based on ${recipe.averageCount} reviews',
                        style: TextStyle(
                          fontSize: 14,
                          color: RecipeColors.neutral500.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Icon(
                Icons.description,
                color: RecipeColors.neutral800.color,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: RecipeColors.neutral800.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            recipe.description,
            style: TextStyle(
              fontSize: 14,
              color: RecipeColors.neutral700.color,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: RecipeColors.neutral800.color,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Estimate Time',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: RecipeColors.neutral800.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            recipe.estimateTime,
            style: TextStyle(
              fontSize: 14,
              color: RecipeColors.neutral700.color,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Icon(
                Icons.restaurant_menu,
                color: RecipeColors.neutral800.color,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Nutrition Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: RecipeColors.neutral800.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: recipe.nutritionInformation.map((nutrition) {
                return NutritionItem(
                  label: nutrition.name,
                  value: nutrition.amount,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewsTabContent extends StatelessWidget {
  final RecipeDetail recipe;

  const ReviewsTabContent({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.comment,
                    color: RecipeColors.neutral800.color,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Comments (${recipe.commentsCount})',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: RecipeColors.neutral800.color,
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => context.router
                    .push(AddReviewRoute(recipeId: recipe.recipeId)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: RecipeColors.primary700.color,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Add Review'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (recipe.reviews.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.rate_review_outlined,
                        size: 64, color: RecipeColors.neutral400.color),
                    const SizedBox(height: 16),
                    Text(
                      'No reviews yet',
                      style: TextStyle(
                        fontSize: 16,
                        color: RecipeColors.neutral600.color,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Be the first to review this recipe!',
                      style: TextStyle(
                        color: RecipeColors.neutral500.color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (recipe.reviews.isNotEmpty)
            ...recipe.reviews.map((review) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ReviewItemDetailed(review: review),
              );
            }),
        ],
      ),
    );
  }
}

class IngredientItem extends StatelessWidget {
  final String text;
  final Color color;

  const IngredientItem({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: RecipeColors.neutral700.color,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class StepItem extends StatelessWidget {
  final int number;
  final String text;

  const StepItem({
    super.key,
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
                '$number',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: RecipeColors.neutral700.color,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NutritionItem extends StatelessWidget {
  final String label;
  final String value;

  const NutritionItem({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: RecipeColors.primary300.color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.circle,
              size: 12,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: RecipeColors.neutral700.color,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: RecipeColors.neutral700.color,
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  final String username;
  final int rating;
  final String comment;
  final Color avatarColor;

  const ReviewItem({
    super.key,
    required this.username,
    required this.rating,
    required this.comment,
    required this.avatarColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: avatarColor,
                child: Text(
                  username.isNotEmpty
                      ? username.substring(0, 1).toUpperCase()
                      : 'U',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                username,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: RecipeColors.neutral800.color,
                ),
              ),
              const Spacer(),
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: RecipeColors.gold700.color,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          if (comment.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              comment,
              style: TextStyle(
                fontSize: 14,
                color: RecipeColors.neutral600.color,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class ReviewItemDetailed extends StatelessWidget {
  final Review review;

  const ReviewItemDetailed({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: review.avatar.isNotEmpty
                    ? NetworkImage(review.avatar) as ImageProvider
                    : const AssetImage('assets/default_avatar.png'),
                child: review.avatar.isEmpty
                    ? Text(
                        review.username.isNotEmpty
                            ? review.username.substring(0, 1).toUpperCase()
                            : 'U',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.username,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: RecipeColors.neutral800.color,
                      ),
                    ),
                    Text(
                      review.timeStamp,
                      style: TextStyle(
                        fontSize: 12,
                        color: RecipeColors.neutral500.color,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: RecipeColors.gold300.color,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: RecipeColors.gold700.color,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${review.rating}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: RecipeColors.gold700.color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (review.comment.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              review.comment,
              style: TextStyle(
                fontSize: 14,
                color: RecipeColors.neutral700.color,
                height: 1.5,
              ),
            ),
          ],
          if (review.images.isNotEmpty) ...[
            const SizedBox(height: 12),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: review.images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Viewing full image')),
                          );
                        },
                        child: Image.network(
                          review.images[index],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey[300],
                            child: const Icon(Icons.image_not_supported),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
