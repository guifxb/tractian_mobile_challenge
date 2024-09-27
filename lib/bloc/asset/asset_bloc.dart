import 'package:flutter_bloc/flutter_bloc.dart';
import 'asset_event.dart';
import 'asset_state.dart';
import '../../repositories/asset_repository.dart';

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  final AssetRepository assetRepository;

  AssetBloc(this.assetRepository) : super(AssetLoading()) {
    on<FetchAssets>(_onFetchAssets);
  }

  Future<void> _onFetchAssets(
      FetchAssets event, Emitter<AssetState> emit) async {
    try {
      emit(AssetLoading());
      final assets = await assetRepository.fetchAllAssets(event.locationId);
      emit(AssetLoaded(assets));
    } catch (e) {
      emit(AssetError(e.toString()));
    }
  }
}
