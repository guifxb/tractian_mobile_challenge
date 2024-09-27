import 'package:equatable/equatable.dart';

abstract class AssetEvent extends Equatable {
  const AssetEvent();

  @override
  List<Object?> get props => [];
}

class FetchAssets extends AssetEvent {
  final String locationId;

  const FetchAssets(this.locationId);

  @override
  List<Object?> get props => [locationId];
}
