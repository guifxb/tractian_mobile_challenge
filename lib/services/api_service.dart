import 'package:http/http.dart' as http;

import '../models/asset.dart';
import '../models/company.dart';
import '../models/location.dart';
import '../utils/api_helper.dart';

class ApiService {
  final String baseUrl;
  final http.Client client;

  ApiService({required this.baseUrl, required this.client});

  Future<List<Company>> fetchCompanies() async {
    Uri uri = Uri.parse('$baseUrl/companies');
    return ApiHelper.getData(uri, (json) => Company.fromJson(json), client);
  }

  Future<List<Location>> fetchLocations(int companyId) async {
    Uri uri = Uri.parse('$baseUrl/companies/$companyId/locations');
    return ApiHelper.getData(uri, (json) => Location.fromJson(json), client);
  }

  Future<List<Asset>> fetchAssets(int locationId) async {
    Uri uri = Uri.parse('$baseUrl/locations/$locationId/assets');
    return ApiHelper.getData(uri, (json) => Asset.fromJson(json), client);
  }
}
