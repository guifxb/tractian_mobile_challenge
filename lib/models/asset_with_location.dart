import 'asset.dart';

class AssetWithLocation extends Asset {
  final String locationId;

  AssetWithLocation({
    required super.id,
    required super.name,
    required this.locationId,
  });

  factory AssetWithLocation.fromJson(Map<String, dynamic> json) {
    return AssetWithLocation(
      id: json['id'],
      name: json['name'],
      locationId: json['locationId'],
    );
  }
}