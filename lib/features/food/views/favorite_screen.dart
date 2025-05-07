import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button and title
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.router.pop(),
                    child: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 24),
                  const Text(
                    'Favorites',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Favorite food items list
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  _buildFoodItem('Semur Bola Daging', 'Dinner', 4.5, '30 mins'),
                  _buildFoodItem('Klepon', 'Snack', 4.5, '20 mins'),
                  _buildFoodItem('Nasi Goreng', 'Dinner', 4.5, '25 mins'),
                  _buildFoodItem('Rujak Cingur', 'Lunch', 4.5, '15 mins'),
                  _buildFoodItem('Nasi Kuning', 'Breakfast', 4.5, '20 mins'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodItem(
      String name, String category, double rating, String cookTime) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Food image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Container(
              width: 80,
              height: 80,
              color: Colors.amber.shade200, // Placeholder color
              child: Center(
                child: Icon(
                  Icons.restaurant,
                  color: Colors.amber.shade700,
                ),
              ),
            ),
          ),

          // Food details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(category),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.orange, size: 16),
                      const Text(
                        ' 1 mile radius',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const Spacer(),
                      const Icon(Icons.star, color: Colors.orange, size: 16),
                      Text(
                        ' $rating',
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.schedule, color: Colors.grey, size: 16),
                      Text(
                        ' $cookTime',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'breakfast':
        return Colors.red;
      case 'lunch':
        return Colors.green;
      case 'dinner':
        return Colors.orange;
      case 'snack':
        return Colors.blue;
      default:
        return Colors.purple;
    }
  }
}
