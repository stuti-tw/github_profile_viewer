import 'package:flutter/material.dart';
import 'package:github_profile_viewer/constants/app_colors.dart';
import 'package:github_profile_viewer/models/github_user.dart';
import 'package:github_profile_viewer/widgets/profile_header.dart';

import '../widgets/github_menusection.dart';
import '../widgets/repository_section.dart';

class ProfileScreen extends StatefulWidget {
  final GitHubUser user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ProfileHeader(user: widget.user),
            const Divider(height: 1, color: AppColors.divider),
            GitHubMenuSection(onItemSelected: (val) {}),
            const SizedBox(height: 16),
            RepositorySection(),
          ],
        ),
      ),
    );
  }
}
