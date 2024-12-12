import 'package:equatable/equatable.dart';

class Landlord extends Equatable {
  final int landlordId;
  final String name;
  final String email;
  final String phoneNumber;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;

  const Landlord({
    required this.landlordId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  factory Landlord.fromJson(Map<String, dynamic> json) {
    return Landlord(
      landlordId: json['landlordId'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'landlordId': landlordId,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'userId': userId,
    };
  }

  Landlord copyWith({
    int? landlordId,
    String? name,
    String? email,
    String? phoneNumber,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
  }) {
    return Landlord(
      landlordId: landlordId ?? this.landlordId,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [
        landlordId,
        name,
        email,
        phoneNumber,
        createdAt,
        updatedAt,
        userId,
      ];
}
