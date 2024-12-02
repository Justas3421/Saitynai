class User {
  final String username;
  final String password;
  final String accessToken;
  final String refreshToken;

  const User({
    this.username = '',
    this.password = '',
    this.accessToken = '',
    this.refreshToken = '',
  });

  static const empty = User();
  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  User copyWith({
    String? username,
    String? password,
  }) {
    return User(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}

enum UserRole {
  admin,
  landlord,
  simple,
}

extension UserRoleExtension on UserRole {
  String get stringValue {
    switch (this) {
      case UserRole.admin:
        return 'Admin';
      case UserRole.landlord:
        return 'Landlord';
      case UserRole.simple:
        return 'Simple';
      default:
        return '';
    }
  }
}
