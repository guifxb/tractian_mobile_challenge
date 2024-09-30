import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_challenge/bloc/node/node_bloc.dart';
import 'package:tractian_challenge/bloc/node/node_event.dart';
import 'package:tractian_challenge/bloc/node/node_state.dart';
import 'package:tractian_challenge/repositories/asset_repository.dart';
import 'package:tractian_challenge/repositories/location_repository.dart';
import 'package:tractian_challenge/models/asset.dart';
import 'package:tractian_challenge/models/location.dart';

class MockAssetRepository extends Mock implements AssetRepository {}
class MockLocationRepository extends Mock implements LocationRepository {}

void main() {
  late MockAssetRepository assetRepository;
  late MockLocationRepository locationRepository;
  late NodeBloc nodeBloc;

  setUp(() {
    assetRepository = MockAssetRepository();
    locationRepository = MockLocationRepository();
    nodeBloc = NodeBloc(
      assetRepository: assetRepository,
      locationRepository: locationRepository,
    );
  });

  tearDown(() {
    nodeBloc.close();
  });

  blocTest<NodeBloc, NodeState>(
    'emits [NodeLoading, NodeLoaded] when FetchNodes is successful',
    build: () {
      when(() => assetRepository.fetchAssets(any()))
          .thenAnswer((_) async => [const Asset(id: '1', name: 'Asset 1', locationId: '', parentId: '', sensorType: '', status: '')]);
      when(() => locationRepository.fetchAllLocations(any()))
          .thenAnswer((_) async => [const Location(id: '1', name: 'Location 1', parentId: '')]);

      return nodeBloc;
    },
    act: (bloc) => bloc.add(const FetchNodes('companyId')),
    expect: () => [
      NodeLoading(),
      isA<NodeLoaded>(),
    ],
    verify: (_) {
      verify(() => assetRepository.fetchAssets(any())).called(1);
      verify(() => locationRepository.fetchAllLocations(any())).called(1);
    },
  );

  blocTest<NodeBloc, NodeState>(
    'emits [NodeLoading, NodeError] when FetchNodes fails',
    build: () {
      when(() => assetRepository.fetchAssets(any()))
          .thenThrow(Exception('Failed to fetch assets'));
      when(() => locationRepository.fetchAllLocations(any()))
          .thenThrow(Exception('Failed to fetch locations'));
      return nodeBloc;
    },
    act: (bloc) => bloc.add(FetchNodes('companyId')),
    expect: () => [
      NodeLoading(),
      const NodeError('Exception: Failed to fetch assets'),
    ],
  );
}
