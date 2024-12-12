class Building {
  final int buildingId;
  final int landlordId;
  final String name;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final int numberOfFloors;
  final DateTime createdAt;
  final DateTime updatedAt;

  Building({
    required this.buildingId,
    required this.landlordId,
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.numberOfFloors,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory constructor to create a Building from JSON
  factory Building.fromJson(Map<String, dynamic> json) {
    return Building(
      buildingId: json['buildingId'] as int,
      landlordId: json['landlordId'] as int,
      name: json['name'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zipCode'] as String,
      numberOfFloors: json['numFloors'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
