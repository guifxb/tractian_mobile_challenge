import 'package:equatable/equatable.dart';

class Asset extends Equatable {
  final String id;
  final String locationId;
  final String name;
  final String parentId;
  final String sensorType;
  final String status;

  const Asset({
    required this.id,
    required this.locationId,
    required this.name,
    required this.parentId,
    required this.sensorType,
    required this.status,
  });

  @override
  List<Object?> get props => [id, name];

  static Asset fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'],
      locationId: json['locationId'] ?? "",
      name: json['name'],
      parentId: json['parentId'] ?? "",
      sensorType: json['sensorType'] ?? "",
      status: json['status'] ?? "",
    );
  }
}
