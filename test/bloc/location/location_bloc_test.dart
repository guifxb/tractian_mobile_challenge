import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_challenge/bloc/location/location_bloc.dart';
import 'package:tractian_challenge/bloc/location/location_event.dart';
import 'package:tractian_challenge/bloc/location/location_state.dart';
import 'package:tractian_challenge/repositories/location_repository.dart';
import 'package:tractian_challenge/models/location.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

void main() {
  late MockLocationRepository locationRepository;
  late LocationBloc locationBloc;

  setUp(() {
    locationRepository = MockLocationRepository();
    locationBloc = LocationBloc(locationRepository);
  });

  tearDown(() {
    locationBloc.close();
  });

  blocTest<LocationBloc, LocationState>(
    'emits [LocationLoading, LocationLoaded] when FetchLocations is successful',
    build: () {
      when(() => locationRepository.fetchAllLocations(any()))
          .thenAnswer((_) async => [const Location(id: '1', name: 'Location 1', parentId: '')]);
      return locationBloc;
    },
    act: (bloc) => bloc.add(const FetchLocations('companyId')),
    expect: () => [
      LocationLoading(),
      const LocationLoaded([Location(id: '1', name: 'Location 1', parentId: '')]),
    ],
    verify: (_) {
      verify(() => locationRepository.fetchAllLocations(any())).called(1);
    },
  );

  blocTest<LocationBloc, LocationState>(
    'emits [LocationLoading, LocationError] when FetchLocations fails',
    build: () {
      when(() => locationRepository.fetchAllLocations(any()))
          .thenThrow(Exception('Failed to fetch locations'));
      return locationBloc;
    },
    act: (bloc) => bloc.add(const FetchLocations('companyId')),
    expect: () => [
      LocationLoading(),
      const LocationError('Exception: Failed to fetch locations'),
    ],
  );
}
