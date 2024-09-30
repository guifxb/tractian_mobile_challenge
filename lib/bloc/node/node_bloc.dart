import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/asset_repository.dart';
import '../../repositories/location_repository.dart';
import '../../utils/build_node_tree.dart';
import 'node_event.dart';
import 'node_state.dart';

class NodeBloc extends Bloc<NodeEvent, NodeState> {
  final AssetRepository assetRepository;
  final LocationRepository locationRepository;

  NodeBloc({
    required this.assetRepository,
    required this.locationRepository,
  }) : super(NodeLoading()) {
    on<FetchNodes>(_onFetchNodes);
  }

  Future<void> _onFetchNodes(FetchNodes event, Emitter<NodeState> emit) async {
    try {
      emit(NodeLoading());

      final assets = await assetRepository.fetchAssets(event.companyId);
      final locations = await locationRepository.fetchAllLocations(event.companyId);

      emit(NodeProcessing());
      final nodes = await compute(buildNodeTreeWrapper, [assets, locations]);

      emit(NodeLoaded(nodes));
    } catch (e) {
      emit(NodeError(e.toString()));
    }
  }
}
