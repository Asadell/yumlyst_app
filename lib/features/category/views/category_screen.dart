import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CategoryScreen extends StatelessWidget {
  final String category;

  const CategoryScreen(
      {super.key, @PathParam('category') required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          category,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          FoodCard(
            name: 'Nasi Kremes',
            imageUrl: 'assets/images/loading_cover.jpg',
            price: 'Rp35.000',
            rating: 4.8,
            reviewCount: 103,
            isPopular: true,
          ),
          FoodCard(
            name: 'Bebek Goreng Sambal Hitam',
            imageUrl: 'assets/images/loading_cover.jpg',
            price: 'Rp45.000',
            rating: 4.9,
            reviewCount: 127,
            isPopular: false,
          ),
          FoodCard(
            name: 'Nasi Pecel',
            imageUrl: 'assets/images/loading_cover.jpg',
            price: 'Rp28.000',
            rating: 4.7,
            reviewCount: 89,
            isPopular: true,
          ),
          FoodCard(
            name: 'Nasi Goreng',
            imageUrl: 'assets/images/loading_cover.jpg',
            price: 'Rp30.000',
            rating: 4.9,
            reviewCount: 156,
            isPopular: false,
          ),
          FoodCard(
            name: 'Tahu Tek',
            imageUrl: 'assets/images/loading_cover.jpg',
            price: 'Rp25.000',
            rating: 4.6,
            reviewCount: 81,
            isPopular: false,
          ),
        ],
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String price;
  final double rating;
  final int reviewCount;
  final bool isPopular;

  const FoodCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.isPopular,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (isPopular)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'HOT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      size: 16,
                      color: Colors.amber[700],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.amber[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '($reviewCount review)',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
