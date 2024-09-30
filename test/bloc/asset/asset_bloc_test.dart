import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_challenge/bloc/asset/asset_bloc.dart';
import 'package:tractian_challenge/bloc/asset/asset_event.dart';
import 'package:tractian_challenge/bloc/asset/asset_state.dart';
import 'package:tractian_challenge/repositories/asset_repository.dart';
import 'package:tractian_challenge/models/asset.dart';

class MockAssetRepository extends Mock implements AssetRepository {}

void main() {
  late MockAssetRepository assetRepository;
  late AssetBloc assetBloc;

  setUp(() {
    assetRepository = MockAssetRepository();
    assetBloc = AssetBloc(assetRepository);
  });

  tearDown(() {
    assetBloc.close();
  });

  blocTest<AssetBloc, AssetState>(
    'emits [AssetLoading, AssetLoaded] when FetchAssets is successful',
    build: () {
      // Mocking repository response
      when(() => assetRepository.fetchAssets(any()))
          .thenAnswer((_) async => [const Asset(id: '1', name: 'Asset 1', locationId: '', parentId: '', sensorType: '', status: '')]);
      return assetBloc;
    },
    act: (bloc) => bloc.add(const FetchAssets('companyId')),
    expect: () => [
      AssetLoading(),
      const AssetLoaded([Asset(id: '1', name: 'Asset 1', locationId: '', parentId: '', sensorType: '', status: '')]),
    ],
    verify: (_) {
      verify(() => assetRepository.fetchAssets(any())).called(1);
    },
  );

  blocTest<AssetBloc, AssetState>(
    'emits [AssetLoading, AssetError] when FetchAssets fails',
    build: () {
      when(() => assetRepository.fetchAssets(any()))
          .thenThrow(Exception('Failed to fetch assets'));
      return assetBloc;
    },
    act: (bloc) => bloc.add(const FetchAssets('companyId')),
    expect: () => [
      AssetLoading(),
      const AssetError('Exception: Failed to fetch assets'),
    ],
  );
}
