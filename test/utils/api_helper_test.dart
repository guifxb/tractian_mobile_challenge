import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:tractian_challenge/models/company.dart';
import 'package:tractian_challenge/utils/api_helper.dart';
import '../mock_http.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('ApiHelper', () {
    final mockClient = MockClient();

    test('fetches data successfully', () async {
      final uri = Uri.parse('https://example.com/companies');
      final mockResponse = jsonEncode([{'id': '1', 'name': 'Company A'}]);

      when(mockClient.get(uri)).thenAnswer((_) async => http.Response(mockResponse, 200));

      final result = await ApiHelper.getData(uri, (json) => Company.fromJson(json), mockClient);
      expect(result, isA<List<Company>>());
      expect(result.first.name, equals('Company A'));
    });

    test('throws exception when API returns non-200 status', () async {
      final uri = Uri.parse('https://example.com/companies');

      when(mockClient.get(uri)).thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => ApiHelper.getData(uri, (json) => Company.fromJson(json), mockClient), throwsException);
    });

    test('throws exception on internal server error', () async {
      final uri = Uri.parse('https://example.com/companies');

      when(mockClient.get(uri)).thenAnswer((_) async => http.Response('Internal Server Error', 500));

      expect(() => ApiHelper.getData(uri, (json) => Company.fromJson(json), mockClient), throwsException);
    });
  });
}
