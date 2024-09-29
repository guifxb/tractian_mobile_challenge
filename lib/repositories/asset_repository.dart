import '../models/asset.dart';
import '../services/api_service.dart';

class AssetRepository {
  final ApiService apiService;

  AssetRepository(this.apiService);

  Future<List<Asset>> fetchAllAssets(String companyId) async {
    return apiService.fetchAssets(companyId);
  }
}
