import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_challenge/bloc/node/node_event.dart';
import 'package:tractian_challenge/bloc/node/node_state.dart';
import 'package:tractian_challenge/repositories/asset_repository.dart';
import 'package:tractian_challenge/repositories/location_repository.dart';
import 'package:tractian_challenge/bloc/node/node_bloc.dart';
import 'package:tractian_challenge/models/node.dart';
import 'package:tractian_challenge/models/asset.dart';
import 'package:tractian_challenge/models/location.dart';
import 'package:tractian_challenge/utils/build_node_tree.dart';

class MockAssetRepository extends Mock implements AssetRepository {}

class MockLocationRepository extends Mock implements LocationRepository {}

class FakeNode extends Fake implements Node {}

void main() {
  late MockAssetRepository assetRepository;
  late MockLocationRepository locationRepository;
  late NodeBloc nodeBloc;

  setUpAll(() {
    registerFallbackValue(FakeNode());
  });

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

  group('NodeBloc', () {
    const companyId = 'testCompanyId';

    final assets = [
      const Asset(id: 'a1', locationId: 'l1', name: 'Asset 1', parentId: '', sensorType: '', status: ''),
    ];

    final locations = [
      const Location(id: 'l1', name: 'Location 1', parentId: ""),
    ];

    final nodes = [
      Node(id: 'n1', name: 'Node 1', type: 'location', children: [], hierarchyLevel: 0),
    ];

    test('initial state is NodeLoading', () {
      expect(nodeBloc.state, NodeLoading());
    });

    blocTest<NodeBloc, NodeState>(
      'emits [NodeLoading, NodeError] when FetchNodes fails',
      build: () {
        when(() => assetRepository.fetchAssets(any())).thenThrow(Exception('Failed to fetch assets'));
        return nodeBloc;
      },
      act: (bloc) => bloc.add(const FetchNodes(companyId)),
      expect: () => [
        NodeLoading(),
        const NodeError('Exception: Failed to fetch assets'),
      ],
      verify: (_) {
        verify(() => assetRepository.fetchAssets(companyId)).called(1);
      },
    );

  });
}
