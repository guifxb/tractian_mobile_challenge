import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object?> get props => [];
}

class FetchLocations extends LocationEvent {
  final String companyId;

  const FetchLocations(this.companyId);

  @override
  List<Object?> get props => [companyId];
}
