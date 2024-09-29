import 'package:http/http.dart' as http;

import '../models/asset.dart';
import '../models/company.dart';
import '../models/location.dart';
import '../utils/api_helper.dart';

class ApiService {
  final String baseUrl;
  final http.Client client;

  static ApiService? _instance;

  factory ApiService({required String baseUrl, http.Client? client}) {
    _instance ??= ApiService._internal(baseUrl: baseUrl, client: client ?? http.Client());
    return _instance!;
  }

  ApiService._internal({required this.baseUrl, required this.client});

  Future<List<Company>> fetchCompanies() async {
    Uri uri = Uri.parse('$baseUrl/companies');
    return ApiHelper.getData(uri, (json) => Company.fromJson(json), client);
  }

  Future<List<Location>> fetchLocations(String companyId) async {
    Uri uri = Uri.parse('$baseUrl/companies/$companyId/locations');
    return ApiHelper.getData(uri, (json) => Location.fromJson(json), client);
  }

  Future<List<Asset>> fetchAssets(String locationId) async {
    Uri uri = Uri.parse('$baseUrl/locations/$locationId/assets');
    return ApiHelper.getData(uri, (json) => Asset.fromJson(json), client);
  }
}
