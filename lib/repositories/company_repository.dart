import '../models/company.dart';
import '../services/api_service.dart';

class CompanyRepository {
  final ApiService apiService;

  CompanyRepository(this.apiService);

  Future<List<Company>> fetchAllCompanies() async {
    return apiService.fetchCompanies();
  }
}

