import 'package:equatable/equatable.dart';

import 'package:equatable/equatable.dart';

abstract class AssetEvent extends Equatable {
  const AssetEvent();

  @override
  List<Object?> get props => [];
}

class FetchAssets extends AssetEvent {
  final String companyId;

  const FetchAssets(this.companyId);

  @override
  List<Object> get props => [companyId];
}

class UpdateSearchQuery extends AssetEvent {
  final String query;

  const UpdateSearchQuery(this.query);

  @override
  List<Object> get props => [query];
}

class ToggleFilter extends AssetEvent {
  final String filter;

  const ToggleFilter(this.filter);

  @override
  List<Object> get props => [filter];
}

class UpdateMaxHierarchyLevel extends AssetEvent {
  final int level;

  const UpdateMaxHierarchyLevel(this.level);

  @override
  List<Object> get props => [level];
}
