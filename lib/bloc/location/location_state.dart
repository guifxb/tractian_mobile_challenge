import 'package:equatable/equatable.dart';
import '../../models/location.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final List<Location> locations;

  const LocationLoaded(this.locations);

  @override
  List<Object?> get props => [locations];
}

class LocationError extends LocationState {
  final String error;

  const LocationError(this.error);

  @override
  List<Object?> get props => [error];
}
