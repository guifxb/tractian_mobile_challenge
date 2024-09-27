import 'asset_component.dart';
import 'asset_sub_asset.dart';
import 'asset_with_location.dart';

class Asset {
  final String id;
  final String name;

  Asset({
    required this.id,
    required this.name,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    if (json['sensorType'] != null) {
      return Component.fromJson(json);
    } else if (json['locationId'] != null) {
      return AssetWithLocation.fromJson(json);
    } else if (json['parentId'] != null) {
      return SubAsset.fromJson(json);
    } else {
      throw Exception("Unknown asset type.");
    }
  }
}
