import 'asset.dart';

class Component extends Asset {
  final String sensorId;
  final String sensorType;
  final String status;
  final String gatewayId;
  final String? parentId;

  Component({
    required super.id,
    required super.name,
    required this.sensorId,
    required this.sensorType,
    required this.status,
    required this.gatewayId,
    this.parentId,
  });

  factory Component.fromJson(Map<String, dynamic> json) {
    return Component(
      id: json['id'],
      name: json['name'],
      sensorId: json['sensorId'],
      sensorType: json['sensorType'],
      status: json['status'],
      gatewayId: json['gatewayId'],
      parentId: json['parentId'],
    );
  }
}
