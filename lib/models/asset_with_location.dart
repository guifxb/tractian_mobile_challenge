import 'asset.dart';

class AssetWithLocation extends Asset {
  final String locationId;

  const AssetWithLocation({
    required super.id,
    required super.name,
    required this.locationId,
  }) : super();

  @override
  List<Object?> get props => [id, name, locationId];

  factory AssetWithLocation.fromJson(Map<String, dynamic> json) {
    return AssetWithLocation(
      id: json['id'],
      name: json['name'],
      locationId: json['locationId'],
    );
  }
}
