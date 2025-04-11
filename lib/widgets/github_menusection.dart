import 'package:flutter/material.dart';
import 'package:github_profile_viewer/constants/app_colors.dart';

class GitHubMenuSection extends StatelessWidget {
  final Function(int) onItemSelected;

  const GitHubMenuSection({
    super.key,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Column(
        children: [
          _buildMenuItem(
            index: 0,
            icon: Icons.book_outlined,
            iconBackground: AppColors.divider,
            title: 'Repositories',
            count: '8',
          ),
          const Divider(height: 1, color: AppColors.divider),
          _buildMenuItem(
            index: 1,
            icon: Icons.star,
            iconBackground: const Color(0xFFE3B341),
            title: 'Starred',
            count: '3',
          ),
          const Divider(height: 1, color: AppColors.divider),
          _buildMenuItem(
            index: 2,
            icon: Icons.business,
            iconBackground: const Color(0xFFE28A50),
            title: 'Organizations',
            count: '0',
          ),
          const Divider(height: 1, color: AppColors.divider),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required int index,
    required IconData icon,
    required Color iconBackground,
    required String title,
    required String count,
  }) {

    return InkWell(
      onTap: () => onItemSelected(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        color: AppColors.background,
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  count,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.textMuted,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
