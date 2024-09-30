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
  List<Object?> get props => [companyId];
}

class ApplyFilters extends AssetEvent {
  final String? searchText;
  final String? sensorType;
  final String? status;

  const ApplyFilters({this.searchText, this.sensorType, this.status});

  @override
  List<Object?> get props => [searchText, sensorType, status];
}
