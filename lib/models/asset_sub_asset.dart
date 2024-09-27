import 'asset.dart';

class SubAsset extends Asset {
  final String parentId;

  SubAsset({
    required super.id,
    required super.name,
    required this.parentId,
  });

  factory SubAsset.fromJson(Map<String, dynamic> json) {
    return SubAsset(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
    );
  }
}