import 'asset.dart';

class SubAsset extends Asset {
  final String parentId;

  const SubAsset({
    required super.id,
    required super.name,
    required this.parentId,
  }) : super();

  @override
  List<Object?> get props => [id, name, parentId];

  factory SubAsset.fromJson(Map<String, dynamic> json) {
    return SubAsset(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
    );
  }
}
