import '../models/location.dart';
import '../services/api_service.dart';

class LocationRepository {
  final ApiService apiService;

  LocationRepository(this.apiService);

  Future<List<Location>> fetchAllLocations(String companyId) async {
    return apiService.fetchLocations(int.parse(companyId));
  }
}
