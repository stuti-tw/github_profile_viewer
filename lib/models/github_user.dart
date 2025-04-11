class GitHubUser {
  final String login;
  final String avatarUrl;
  final String? name;
  final String? bio;
  final String? location;
  final String? email;
  final String? blog;
  final String? company;
  final int followers;
  final int following;
  final int publicRepos;
  final int publicGists;
  final String htmlUrl;
  final String createdAt;

  GitHubUser({
    required this.login,
    required this.avatarUrl,
    this.name,
    this.bio,
    this.location,
    this.email,
    this.blog,
    this.company,
    required this.followers,
    required this.following,
    required this.publicRepos,
    required this.publicGists,
    required this.htmlUrl,
    required this.createdAt,
  });

  factory GitHubUser.fromJson(Map<String, dynamic> json) {
    return GitHubUser(
      login: json['login'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      name: json['name'],
      bio: json['bio'],
      location: json['location'],
      email: json['email'],
      blog: json['blog'],
      company: json['company'],
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
      publicRepos: json['public_repos'] ?? 0,
      publicGists: json['public_gists'] ?? 0,
      htmlUrl: json['html_url'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}