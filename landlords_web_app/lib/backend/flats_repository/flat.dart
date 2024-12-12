class Flat {
  int flatId;
  int buildingId;
  String flatNumber;
  int numBedrooms;
  int numBathrooms;
  double rent;
  bool isOccupied;
  String tenantName;
  DateTime createdAt;
  DateTime updatedAt;

  Flat({
    required this.flatId,
    required this.buildingId,
    required this.flatNumber,
    required this.numBedrooms,
    required this.numBathrooms,
    required this.rent,
    required this.isOccupied,
    required this.tenantName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Flat.fromJson(Map<String, dynamic> json) {
    return Flat(
      flatId: json['flatId'],
      buildingId: json['buildingId'],
      flatNumber: json['flatNumber'],
      numBedrooms: json['numBedrooms'],
      numBathrooms: json['numBathrooms'],
      rent: json['rent'],
      isOccupied: json['isOccupied'],
      tenantName: json['tenantName'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
