import '../models/asset.dart';
import '../services/api_service.dart';

class AssetRepository {
  final ApiService apiService;

  AssetRepository(this.apiService);

  Future<List<Asset>> fetchAssets(String companyId) async {
    return apiService.fetchAssets(companyId);
  }
}
