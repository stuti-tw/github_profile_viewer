import 'package:flutter/material.dart';
import 'package:github_profile_viewer/constants/app_colors.dart';

class RepositorySection extends StatelessWidget {
  const RepositorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.star_border,
                color: AppColors.textMuted,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Popular',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200, // Fixed height for the cards row
            child: Row(
              children: [
                Expanded(
                  child: RepositoryCard(
                    ownerAvatar: 'https://github.com/octocat.png',
                    ownerName: 'octocat',
                    repoName: 'Spoon-Knife',
                    description: 'This repo is for demonstration purposes only.',
                    stars: '12,932',
                    language: 'HTML',
                    languageColor: const Color(0xFFE34C26),
                  ),
                ),
                const SizedBox(width: 12),
                // This is for the second card that's partially visible
                Expanded(
                  child: RepositoryCard(
                    ownerAvatar: 'https://github.com/octocat.png',
                    ownerName: 'octocat',
                    repoName: 'Hello',
                    description: 'My first repository',
                    stars: '2,925',
                    language: '',
                    languageColor: Colors.transparent,
                    isPartial: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RepositoryCard extends StatelessWidget {
  final String ownerAvatar;
  final String ownerName;
  final String repoName;
  final String description;
  final String stars;
  final String language;
  final Color languageColor;
  final bool isPartial;

  const RepositoryCard({
    super.key,
    required this.ownerAvatar,
    required this.ownerName,
    required this.repoName,
    required this.description,
    required this.stars,
    required this.language,
    required this.languageColor,
    this.isPartial = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF21262D),
        borderRadius: BorderRadius.circular(6),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Owner avatar and name
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        ownerAvatar,
                        width: 20,
                        height: 20,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 20,
                            height: 20,
                            color: AppColors.buttonBg,
                            child: const Icon(Icons.person, size: 12, color: AppColors.textPrimary),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      ownerName,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Repository name
                Text(
                  repoName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                // Repository description
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Using Expanded instead of Spacer
          const Expanded(child: SizedBox()),
          // Footer with stars and language
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(
                  Icons.star_border,
                  size: 16,
                  color: AppColors.textMuted,
                ),
                const SizedBox(width: 4),
                Text(
                  stars,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
                if (language.isNotEmpty) ...[
                  const SizedBox(width: 16),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: languageColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    language,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Alternative implementation without Spacer or Expanded
class RepositoryCardAlt extends StatelessWidget {
  final String ownerAvatar;
  final String ownerName;
  final String repoName;
  final String description;
  final String stars;
  final String language;
  final Color languageColor;
  final bool isPartial;

  const RepositoryCardAlt({
    super.key,
    required this.ownerAvatar,
    required this.ownerName,
    required this.repoName,
    required this.description,
    required this.stars,
    required this.language,
    required this.languageColor,
    this.isPartial = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180, // Fixed height card
      decoration: BoxDecoration(
        color: const Color(0xFF21262D),
        borderRadius: BorderRadius.circular(6),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between top and bottom
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Owner avatar and name
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        ownerAvatar,
                        width: 20,
                        height: 20,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 20,
                            height: 20,
                            color: AppColors.buttonBg,
                            child: const Icon(Icons.person, size: 12, color: AppColors.textPrimary),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      ownerName,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Repository name
                Text(
                  repoName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                // Repository description
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Footer with stars and language
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(
                  Icons.star_border,
                  size: 16,
                  color: AppColors.textMuted,
                ),
                const SizedBox(width: 4),
                Text(
                  stars,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
                if (language.isNotEmpty) ...[
                  const SizedBox(width: 16),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: languageColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    language,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Example of how to use this in a parent widget:
class RepositoryScreen extends StatelessWidget {
  const RepositoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          children: const [
            RepositorySection(),
            // Add other sections as needed
          ],
        ),
      ),
    );
  }
}