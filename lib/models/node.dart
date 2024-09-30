import 'package:equatable/equatable.dart';

class Node extends Equatable {
  final String id;
  final String name;
  final String type; // location, asset, component
  final String? status;
  final String? sensorType;
  final List<Node> children;
  int hierarchyLevel;

  Node({
    required this.id,
    required this.name,
    required this.type,
    this.status,
    this.sensorType,
    this.children = const [],
    this.hierarchyLevel = 0,
  });

  @override
  List<Object?> get props => [id, name, type, status, sensorType, children];

  Node copyWith({
    String? id,
    String? name,
    String? type,
    String? status,
    String? sensorType,
    List<Node>? children,
    int? hierarchyLevel,
  }) {
    return Node(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      status: status ?? this.status,
      sensorType: sensorType ?? this.sensorType,
      children: children ?? this.children,
      hierarchyLevel: hierarchyLevel ?? this.hierarchyLevel,
    );
  }
}
