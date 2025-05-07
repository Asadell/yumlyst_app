import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/routes/app_route.dart';
import 'package:recipe_app/style/colors/recipe_colors.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                _buildProfileHeader(),
                const SizedBox(height: 32),
                _buildAccountSection(context),
                const SizedBox(height: 32),
                _buildOthersSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: RecipeColors.primary700.color,
                width: 2,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/loading_cover.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'kyiweza',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: RecipeColors.neutral700.color,
          ),
        ),
        const SizedBox(height: 16),
        _buildProfileMenuItem(
          icon: Icons.person,
          title: 'Update Profile',
          iconColor: RecipeColors.primary700.color,
          onTap: () => context.router.push(UpdateProfileRoute()),
        ),
        _buildProfileMenuItem(
          icon: Icons.lock,
          title: 'Reset Password',
          iconColor: RecipeColors.primary700.color,
          onTap: () => context.router.push(ResetPasswordRoute()),
        ),
        _buildProfileMenuItem(
          icon: Icons.history,
          title: 'Histories',
          iconColor: RecipeColors.primary700.color,
          onTap: () => context.router.push(HistoryRoute()),
        ),
        _buildProfileMenuItem(
          icon: Icons.favorite,
          title: 'Favorites',
          iconColor: RecipeColors.primary700.color,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildOthersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Others',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: RecipeColors.neutral700.color,
          ),
        ),
        const SizedBox(height: 16),
        _buildProfileMenuItem(
          icon: Icons.shield,
          title: 'Privacy Policy',
          iconColor: RecipeColors.secondary700.color,
          onTap: () {},
        ),
        _buildProfileMenuItem(
          icon: Icons.description,
          title: 'Terms and Conditions',
          iconColor: RecipeColors.secondary700.color,
          onTap: () {},
        ),
        _buildProfileMenuItem(
          icon: Icons.help_center,
          title: 'Help Center',
          iconColor: RecipeColors.secondary700.color,
          onTap: () {},
        ),
        const SizedBox(height: 32),
        _buildLogoutButton(),
      ],
    );
  }

  Widget _buildProfileMenuItem({
    required IconData icon,
    required String title,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: RecipeColors.neutral400.color,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: RecipeColors.error500.color,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
