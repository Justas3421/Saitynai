enum UserRole { admin, landlord, simple }

class User {
  final String username;
  final String password;
  final String accessToken;
  final String refreshToken;
  final String phoneNumber;
  final UserRole role;
  final String userId;

  const User({
    this.username = '',
    this.password = '',
    this.accessToken = '',
    this.refreshToken = '',
    this.role = UserRole.simple,
    this.userId = '',
    this.phoneNumber = '',
  });

  static const empty = User();
  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  User copyWith({
    String? username,
    String? password,
    String? accessToken,
    String? refreshToken,
    UserRole? role,
    String? userId,
    String? phoneNumber,
  }) {
    return User(
      username: username ?? this.username,
      password: password ?? this.password,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      role: role ?? this.role,
      userId: userId ?? this.userId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
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

  static UserRole fromString(String value) {
    switch (value) {
      case 'Admin':
        return UserRole.admin;
      case 'Landlord':
        return UserRole.landlord;
      case 'Simple':
        return UserRole.simple;
      default:
        return UserRole.simple;
    }
  }
}
