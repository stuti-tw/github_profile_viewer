import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:github_profile_viewer/models/github_user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum GitHubState { initial, loading, loaded, error }

class GitHubProvider extends ChangeNotifier {
  GitHubState _state = GitHubState.initial;
  GitHubUser? _user;
  String _errorMessage = '';
  List<String> _recentSearches = [];
  final SharedPreferences _prefs;

  GitHubProvider(this._prefs) {
    _loadRecentSearches();
  }

  GitHubState get state => _state;

  GitHubUser? get user => _user;

  String get errorMessage => _errorMessage;

  List<String> get recentSearches => _recentSearches;

  void _loadRecentSearches() {
    _recentSearches = _prefs.getStringList('recent_searches') ?? [];
    notifyListeners();
  }

  void _saveRecentSearch(String username) {
    if (username.isEmpty) return;

    // Remove if exists and add to the beginning
    _recentSearches.remove(username);
    _recentSearches.insert(0, username);

    // Keep only the last 5 searches
    if (_recentSearches.length > 5) {
      _recentSearches = _recentSearches.sublist(0, 5);
    }

    _prefs.setStringList('recent_searches', _recentSearches);
    notifyListeners();
  }

  Future<void> fetchUserProfile(String username) async {
    if (username.isEmpty) {
      _state = GitHubState.error;
      _errorMessage = 'Please enter a username';
      notifyListeners();
      return;
    }

    _state = GitHubState.loading;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://api.github.com/users/$username'),
        headers: {'Accept': 'application/vnd.github.v3+json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _user = GitHubUser.fromJson(data);
        _state = GitHubState.loaded;
        _saveRecentSearch(username);
      } else if (response.statusCode == 404) {
        _state = GitHubState.error;
        _errorMessage = 'User not found';
      } else {
        _state = GitHubState.error;
        _errorMessage =
            'Failed to load user data. Status: ${response.statusCode}';
      }
    } catch (e) {
      _state = GitHubState.error;
      _errorMessage = 'Network error: $e';
    }

    notifyListeners();
  }

  void clearSearch() {
    _state = GitHubState.initial;
    _user = null;
    notifyListeners();
  }
}
