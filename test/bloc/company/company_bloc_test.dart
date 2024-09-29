import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_challenge/bloc/company/company_bloc.dart';
import 'package:tractian_challenge/bloc/company/company_event.dart';
import 'package:tractian_challenge/bloc/company/company_state.dart';
import 'package:tractian_challenge/models/company.dart';
import 'package:tractian_challenge/repositories/company_repository.dart';


class MockCompanyRepository extends Mock implements CompanyRepository {}

void main() {
  late CompanyBloc companyBloc;
  late MockCompanyRepository mockCompanyRepository;

  setUp(() {
    mockCompanyRepository = MockCompanyRepository();
    companyBloc = CompanyBloc(mockCompanyRepository);
  });

  tearDown(() {
    companyBloc.close();
  });

  group('CompanyBloc Tests', () {
    blocTest<CompanyBloc, CompanyState>(
      'emits [CompanyLoading, CompanyLoaded] with correct data when FetchCompanies is added and fetch is successful',
      build: () {
        when(() => mockCompanyRepository.fetchAllCompanies()).thenAnswer(
              (_) async => [const Company(id: '1', name: 'Company 1')],
        );
        return companyBloc;
      },
      act: (bloc) => bloc.add(FetchCompanies()),
      expect: () => [
        CompanyLoading(),
        const CompanyLoaded([Company(id: '1', name: 'Company 1')]),
      ],
    );

    blocTest<CompanyBloc, CompanyState>(
      'emits [CompanyLoading, CompanyError] when FetchCompanies is added and fetch fails',
      build: () {
        when(() => mockCompanyRepository.fetchAllCompanies()).thenThrow(Exception('Failed to fetch companies'));
        return companyBloc;
      },
      act: (bloc) => bloc.add(FetchCompanies()),
      expect: () => [
        CompanyLoading(),
        const CompanyError('Exception: Failed to fetch companies'),
      ],
    );
  });
}
