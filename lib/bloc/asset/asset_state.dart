import 'package:equatable/equatable.dart';
import '../../models/asset.dart';

abstract class AssetState extends Equatable {
  const AssetState();

  @override
  List<Object?> get props => [];
}

class AssetLoading extends AssetState {}

class AssetError extends AssetState {
  final String message;

  const AssetError(this.message);

  @override
  List<Object?> get props => [message];
}

class AssetLoaded extends AssetState {
  final List<Asset> assets;

  const AssetLoaded(this.assets);

  @override
  List<Object?> get props => [assets];
}

class AssetFiltered extends AssetState {
  final List<Asset> filteredAssets;

  const AssetFiltered(this.filteredAssets);

  @override
  List<Object?> get props => [filteredAssets];
}
