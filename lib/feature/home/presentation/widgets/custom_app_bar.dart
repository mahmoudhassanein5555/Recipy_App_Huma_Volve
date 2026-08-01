import 'package:flutter/material.dart';
import 'package:reciepe_app/core/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onProfilePressed;

  const CustomAppBar({
    super.key,
    this.title = 'Seafood',
    this.onMenuPressed,
    this.onProfilePressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        color: AppColors.background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left menu button
            IconButton(
              onPressed: onMenuPressed ?? () {},
              icon: const Icon(
                Icons.menu,
                color: AppColors.primaryBrown,
                size: 26,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            // Title
            Text(
              title,
              style: const TextStyle(
                color: AppColors.primaryBrown,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.2,
              ),
            ),
            // User Avatar
            GestureDetector(
              onTap: onProfilePressed,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.subtleBorder, width: 1.5),
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://images.unsplash.com/photo-1577219491135-ce391730fb2c?auto=format&fit=crop&w=150&q=80',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const ColoredBox(
                        color: AppColors.cardBackground,
                        child: Icon(
                          Icons.person,
                          color: AppColors.primaryBrown,
                          size: 22,
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const ColoredBox(
                        color: AppColors.cardBackground,
                        child: Center(
                          child: SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.primaryBrown,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
