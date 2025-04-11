import 'package:flutter/material.dart';
import 'package:github_profile_viewer/providers/github_provider.dart';
import 'package:github_profile_viewer/screens/profile_screen.dart';
import 'package:github_profile_viewer/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GitHubProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          (provider.state == GitHubState.loaded) ? '' : 'GitHub Profile Viewer',
        ),
        centerTitle: true,
        leading:
            (provider.state == GitHubState.loaded)
                ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => provider.clearSearch(),
                )
                : Container(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            if (provider.state != GitHubState.loaded) GitHubSearchBar(),
            const SizedBox(height: 8),
            Expanded(child: _buildBody(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final provider = Provider.of<GitHubProvider>(context);

    switch (provider.state) {
      case GitHubState.initial:
        return _buildInitialState(context);
      case GitHubState.loading:
        return _buildLoadingState();
      case GitHubState.loaded:
        return ProfileScreen(user: provider.user!);
      case GitHubState.error:
        return _buildErrorState(provider.errorMessage);
    }
  }

  Widget _buildInitialState(BuildContext context) {
    final provider = Provider.of<GitHubProvider>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search, size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'Search for a GitHub user',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          if (provider.recentSearches.isNotEmpty) ...[
            const SizedBox(height: 32),
            const Text(
              'Recent Searches',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: provider.recentSearches.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ActionChip(
                      avatar: const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.history,
                          size: 16,
                          color: Color(0xffffffff),
                        ),
                      ),
                      label: Text(provider.recentSearches[index]),
                      onPressed: () {
                        provider.fetchUserProfile(
                          provider.recentSearches[index],
                        );
                      },
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

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Searching GitHub...'),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 60, color: Colors.redAccent),
          const SizedBox(height: 16),
          Text(
            'Error!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red[700]),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Try searching for another username',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
