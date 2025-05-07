import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/routes/app_route.dart';
import 'package:recipe_app/style/colors/recipe_colors.dart';

@RoutePage()
class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({super.key});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isFavorite = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        child: Column(
          children: [
            // Header with video preview and controls
            Stack(
              children: [
                // Video thumbnail or preview
                Container(
                  height: 220,
                  width: double.infinity,
                  color: Colors.black,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.network(
                        'https://i.ytimg.com/vi/MOCK_URL/maxresdefault.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      // Play button overlay
                      Icon(
                        Icons.play_circle_fill,
                        color: Colors.white.withOpacity(0.8),
                        size: 64,
                      ),
                      // Video progress indicator
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            // Time indicator
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
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
                            // Progress bar
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
                      // Video source
                      Positioned(
                        bottom: 8,
                        left: 12,
                        child: Text(
                          'Source: https://www.youtube.com/watch?v=JdSP3CtnTr9B',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Top app bar with back button and favorite
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back button
                        IconButton(
                          icon: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(Icons.arrow_back, color: Colors.black),
                          ),
                          onPressed: () => context.router.pop(),
                        ),
                        // Recipe title
                        Text(
                          'Nasi Goreng',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        // Favorite button
                        IconButton(
                          icon: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Tab Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: Offset(0, 2),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: RecipeColors.primary700.color,
                unselectedLabelColor: RecipeColors.neutral500.color,
                indicatorColor: RecipeColors.primary700.color,
                tabs: [
                  Tab(text: 'Instructions'),
                  Tab(text: 'About'),
                  Tab(text: 'Reviews'),
                ],
                onTap: (index) {
                  switch (index) {
                    case 0:
                      // Already on this tab
                      break;
                    case 1:
                      // context.router.push(AboutRoute());
                      break;
                    case 2:
                      // context.router.push(ReviewRoute());
                      break;
                  }
                },
              ),
            ),

            // Tab View Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Instructions Tab
                  InstructionsTabContent(),

                  // About Tab
                  AboutTabContent(),

                  // Reviews Tab
                  ReviewsTabContent(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InstructionsTabContent extends StatelessWidget {
  const InstructionsTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ingredients Section
          Text(
            'Ingredients',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: RecipeColors.neutral800.color,
            ),
          ),
          SizedBox(height: 12),

          // Ingredients Grid
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 5,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: [
              IngredientItem(
                  text: '2 piring nasi', color: RecipeColors.primary300.color),
              IngredientItem(
                  text: '1 ikat sawi', color: RecipeColors.primary300.color),
              IngredientItem(
                  text: 'Telur ayam', color: RecipeColors.primary300.color),
              IngredientItem(
                  text: 'Daun bawang', color: RecipeColors.primary300.color),
              IngredientItem(
                  text: 'Daging penyedap',
                  color: RecipeColors.primary300.color),
              IngredientItem(
                  text: '1 sdm kecap manis',
                  color: RecipeColors.primary300.color),
              IngredientItem(
                  text: 'Sedkit sasa', color: RecipeColors.primary300.color),
              IngredientItem(
                  text: '4 cube reneng besar',
                  color: RecipeColors.primary300.color),
              IngredientItem(
                  text: '6 siung bawang merah',
                  color: RecipeColors.primary300.color),
              IngredientItem(
                  text: '6 siung bawang putih',
                  color: RecipeColors.primary300.color),
              IngredientItem(
                  text: '3 kemiri', color: RecipeColors.primary300.color),
              IngredientItem(
                  text: '1 sdt terasi matang',
                  color: RecipeColors.primary300.color),
              IngredientItem(
                  text: 'Cabe rawit', color: RecipeColors.primary300.color),
            ],
          ),

          SizedBox(height: 24),

          // Tools Section
          Text(
            'Tools',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: RecipeColors.neutral800.color,
            ),
          ),
          SizedBox(height: 12),

          // Tools Grid
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 5,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: [
              IngredientItem(
                  text: 'Penggorengan', color: RecipeColors.primary300.color),
              IngredientItem(
                  text: 'Pisau', color: RecipeColors.primary300.color),
              IngredientItem(
                  text: 'Ulek / Blender', color: RecipeColors.primary300.color),
              IngredientItem(
                  text: 'Kompor', color: RecipeColors.primary300.color),
            ],
          ),

          SizedBox(height: 24),

          // Steps Section
          Text(
            'Steps',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: RecipeColors.neutral800.color,
            ),
          ),
          SizedBox(height: 12),

          // Steps List
          StepItem(
              number: 1,
              text:
                  'Ulek bawang merah, bawang putih, kemiri, cabe merah, cabe rawit, dan kemiri'),
          StepItem(number: 2, text: 'Sisihkan bumbu tersebut'),
          StepItem(number: 3, text: 'Panaskan minyak'),
        ],
      ),
    );
  }
}

class AboutTabContent extends StatelessWidget {
  const AboutTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Review Summary
          Text(
            'Review Summary',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: RecipeColors.neutral800.color,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Reviewed 12 times',
            style: TextStyle(
              fontSize: 14,
              color: RecipeColors.neutral500.color,
            ),
          ),
          SizedBox(height: 12),

          // Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '4.9',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: RecipeColors.primary700.color,
                ),
              ),
              Icon(Icons.star, color: RecipeColors.primary700.color, size: 20),
            ],
          ),

          SizedBox(height: 24),

          // Description
          Text(
            'Description',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: RecipeColors.neutral800.color,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Nasi goreng adalah hidangan khas Indonesia yang terdiri dari nasi yang digoreng bersama bumbu, seperti bawang putih, bawang merah, kecap, dan rempah-rempah lainnya, sering kali ditambahkan dengan telur, daging, atau seafood. Rasanya gurih dan pedas dengan aroma yang khas.',
            style: TextStyle(
              fontSize: 14,
              color: RecipeColors.neutral700.color,
              height: 1.5,
            ),
          ),

          SizedBox(height: 24),

          // Estimate Time
          Text(
            'Estimate Time',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: RecipeColors.neutral800.color,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '5 - 15 menit',
            style: TextStyle(
              fontSize: 14,
              color: RecipeColors.neutral700.color,
            ),
          ),

          SizedBox(height: 24),

          // Nutrition Information
          Text(
            'Nutrition Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: RecipeColors.neutral800.color,
            ),
          ),
          SizedBox(height: 16),

          // Nutrition items
          NutritionItem(label: 'Energi', value: '350 kkal'),
          NutritionItem(label: 'Lemak', value: '15 gram'),
          NutritionItem(label: 'Karbohidrat', value: '200 gram'),
          NutritionItem(label: 'Protein', value: '20 gram'),
        ],
      ),
    );
  }
}

class ReviewsTabContent extends StatelessWidget {
  const ReviewsTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Reviews
          ReviewItem(
            username: 'ralfidish',
            rating: 5,
            comment: 'resepnya enak!',
            avatarColor: Colors.orange,
          ),
          SizedBox(height: 16),

          ReviewItem(
            username: 'ameliakw',
            rating: 5,
            comment: 'resepnya simple!',
            avatarColor: Colors.purple,
          ),
          SizedBox(height: 16),

          ReviewItem(
            username: 'meyadam',
            rating: 5,
            comment: 'keren, langsung bisa jadian ketemu mama mertua',
            avatarColor: Colors.green,
          ),
          SizedBox(height: 16),

          ReviewItem(
            username: 'idmdragon',
            rating: 4,
            comment: '',
            avatarColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}

// Helper widgets
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
        SizedBox(width: 8),
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
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number. ',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: RecipeColors.neutral700.color,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: RecipeColors.neutral700.color,
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
            child: Icon(
              Icons.circle,
              size: 12,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: RecipeColors.neutral700.color,
            ),
          ),
          Spacer(),
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
    return GestureDetector(
      onTap: () => context.router.push(AddReviewRoute()),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Avatar
                CircleAvatar(
                  backgroundColor: avatarColor,
                  child: Text(
                    username.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 12),

                // Username
                Text(
                  username,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: RecipeColors.neutral800.color,
                  ),
                ),

                Spacer(),

                // Rating
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
              SizedBox(height: 8),
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
      ),
    );
  }
}
