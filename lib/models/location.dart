import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String id;
  final String name;
  final String parentId;

  const Location({
    required this.id,
    required this.name,
    required this.parentId
  });

  @override
  List<Object?> get props => [id, name, parentId];

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'] ?? "",
    );
  }
}
