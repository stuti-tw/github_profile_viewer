import 'package:flutter/material.dart';
import 'package:github_profile_viewer/providers/github_provider.dart';
import 'package:provider/provider.dart';

class GitHubSearchBar extends StatefulWidget {
  const GitHubSearchBar({super.key});

  @override
  _GitHubSearchBarState createState() => _GitHubSearchBarState();
}

class _GitHubSearchBarState extends State<GitHubSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _showDropdown = false;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GitHubProvider>(context);
    final recentSearches = provider.recentSearches;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: 'Search GitHub username',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              filled: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _controller.clear();
                  setState(() {});
                },
              )
                  : null,
            ),
            onChanged: (value) {
              setState(() {
                _showDropdown = value.isNotEmpty && recentSearches.isNotEmpty;
              });
            },
            onTap: () {
              setState(() {
                _showDropdown = _controller.text.isEmpty && recentSearches.isNotEmpty;
              });
            },
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                provider.fetchUserProfile(value);
                _focusNode.unfocus();
                setState(() {
                  _showDropdown = false;
                });
              }
            },
          ),
          if (_showDropdown)
            Container(
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: recentSearches.length,
                itemBuilder: (context, index) {
                  final search = recentSearches[index];
                  bool matches = _controller.text.isEmpty ||
                      search.toLowerCase().contains(_controller.text.toLowerCase());

                  if (!matches) return const SizedBox.shrink();

                  return ListTile(
                    leading: const Icon(Icons.history),
                    title: Text(search),
                    dense: true,
                    onTap: () {
                      _controller.text = search;
                      provider.fetchUserProfile(search);
                      _focusNode.unfocus();
                      setState(() {
                        _showDropdown = false;
                      });
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}