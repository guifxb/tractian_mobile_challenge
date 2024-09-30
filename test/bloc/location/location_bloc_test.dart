import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_challenge/bloc/location/location_bloc.dart';
import 'package:tractian_challenge/bloc/location/location_event.dart';
import 'package:tractian_challenge/bloc/location/location_state.dart';
import 'package:tractian_challenge/models/location.dart';
import 'package:tractian_challenge/repositories/location_repository.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

void main() {
  late LocationBloc locationBloc;
  late MockLocationRepository mockLocationRepository;

  setUp(() {
    mockLocationRepository = MockLocationRepository();
    locationBloc = LocationBloc(mockLocationRepository);
  });

  tearDown(() {
    locationBloc.close();
  });

  group('LocationBloc Tests', () {
    test('initial state is LocationLoading', () {
      expect(locationBloc.state, equals(LocationLoading()));
    });


    blocTest<LocationBloc, LocationState>(
      'emits [LocationLoading, LocationError] when FetchLocations fails',
      build: () {
        // Mock an error response from repository
        when(() => mockLocationRepository.fetchAllLocations(any()))
            .thenThrow(Exception('Failed to fetch locations'));
        return locationBloc;
      },
      act: (bloc) => bloc.add(const FetchLocations('1')),
      expect: () => [
        LocationLoading(),
        const LocationError('Exception: Failed to fetch locations'),
      ],
    );
  });
}
