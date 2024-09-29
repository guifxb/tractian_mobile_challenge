import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:tractian_challenge/models/asset_component.dart';
import 'package:tractian_challenge/models/asset_sub_asset.dart';
import 'package:tractian_challenge/models/asset_with_location.dart';
import 'package:tractian_challenge/models/company.dart';
import 'package:tractian_challenge/models/location.dart';
import 'package:tractian_challenge/services/api_service.dart';
import '../mock_http.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('ApiService', () {
    final mockClient = MockClient();
    final apiService =
        ApiService(baseUrl: 'https://example.com', client: mockClient);

    // Testing endpoint /companies
    test('fetches companies successfully', () async {
      final mockResponse = jsonEncode([
        {'id': '1', 'name': 'Company A'}
      ]);

      when(mockClient.get(Uri.parse('https://example.com/companies')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      final result = await apiService.fetchCompanies();
      expect(result, isA<List<Company>>());
      expect(result.first.name, equals('Company A'));
    });

    test('throws exception on fetch companies failure', () async {
      when(mockClient.get(Uri.parse('https://example.com/companies')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => apiService.fetchCompanies(), throwsException);
    });

    // Testing endpoint /companies/:companyId/locations
    test('fetches locations successfully', () async {
      final mockResponse = jsonEncode([
        {'id': '1', 'name': 'Location A', 'parentId': '1'}
      ]);

      when(mockClient
              .get(Uri.parse('https://example.com/companies/1/locations')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      final result = await apiService.fetchLocations('1');
      expect(result, isA<List<Location>>());
      expect(result.first.name, equals('Location A'));
    });

    test('throws exception on fetch locations failure', () async {
      when(mockClient
              .get(Uri.parse('https://example.com/companies/1/locations')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => apiService.fetchLocations('1'), throwsException);
    });

    // Test for Component
    test('fetches Component successfully', () async {
      final mockResponse = jsonEncode([
        {
          "id": "1",
          "name": "Motor",
          "sensorId": "MTC052",
          "sensorType": "vibration",
          "status": "operating",
          "gatewayId": "GATEWAY123"
        }
      ]);

      when(mockClient.get(Uri.parse('https://example.com/locations/1/assets')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      final result = await apiService.fetchAssets('1');
      expect(result, isA<List>());
      expect(result.first, isA<Component>());
      expect((result.first as Component).sensorType, equals('vibration'));
    });

    // Test for AssetWithLocation
    test('fetches AssetWithLocation successfully', () async {
      final mockResponse = jsonEncode([
        {"id": "2", "name": "Conveyor Belt", "locationId": "LOC123"}
      ]);

      when(mockClient.get(Uri.parse('https://example.com/locations/1/assets')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      final result = await apiService.fetchAssets('1');
      expect(result, isA<List>());
      expect(result.first, isA<AssetWithLocation>());
      expect((result.first as AssetWithLocation).locationId, equals('LOC123'));
    });
    test('throws exception on fetch assets failure', () async {
      when(mockClient.get(Uri.parse('https://example.com/locations/1/assets')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => apiService.fetchAssets('1'), throwsException);
    });

    // Test for SubAsset
    test('fetches SubAsset successfully', () async {
      final mockResponse = jsonEncode([
        {"id": "3", "name": "Motor Sub Asset", "parentId": "ASSET_PARENT123"}
      ]);

      when(mockClient.get(Uri.parse('https://example.com/locations/1/assets')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      final result = await apiService.fetchAssets('1');
      expect(result, isA<List>());
      expect(result.first, isA<SubAsset>());
      expect((result.first as SubAsset).parentId, equals('ASSET_PARENT123'));
    });

    // Test for unknown asset type
    test('throws exception for unknown asset type', () async {
      final mockResponse = jsonEncode([
        {"id": "4", "name": "Unknown Asset"}
      ]);

      when(mockClient.get(Uri.parse('https://example.com/locations/1/assets')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      expect(() => apiService.fetchAssets('1'), throwsException);
    });

    // Testing error 500 for companies
    test('handles internal server error when fetching companies', () async {
      when(mockClient.get(Uri.parse('https://example.com/companies')))
          .thenAnswer((_) async => http.Response('Internal Server Error', 500));

      expect(() => apiService.fetchCompanies(), throwsException);
    });

    // Testing error 500 for locations
    test('handles internal server error when fetching locations', () async {
      when(mockClient
              .get(Uri.parse('https://example.com/companies/1/locations')))
          .thenAnswer((_) async => http.Response('Internal Server Error', 500));

      expect(() => apiService.fetchLocations('1'), throwsException);
    });

    // Testing error 500 for assets
    test('handles internal server error when fetching assets', () async {
      when(mockClient.get(Uri.parse('https://example.com/locations/1/assets')))
          .thenAnswer((_) async => http.Response('Internal Server Error', 500));

      expect(() => apiService.fetchAssets('1'), throwsException);
    });
  });
}
