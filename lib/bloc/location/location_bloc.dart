import 'package:flutter_bloc/flutter_bloc.dart';
import 'location_event.dart';
import 'location_state.dart';
import '../../repositories/location_repository.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository locationRepository;

  LocationBloc(this.locationRepository) : super(LocationLoading()) {
    on<FetchLocations>(_onFetchLocations);
  }

  Future<void> _onFetchLocations(
      FetchLocations event, Emitter<LocationState> emit) async {
    try {
      emit(LocationLoading());
      final locations =
      await locationRepository.fetchAllLocations(event.companyId);
      emit(LocationLoaded(locations));
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }
}
