import 'package:equatable/equatable.dart';
import 'asset_component.dart';
import 'asset_sub_asset.dart';
import 'asset_with_location.dart';

class Asset extends Equatable {
  final String id;
  final String name;

  const Asset({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];

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
