import 'package:flutter_bloc/flutter_bloc.dart';
import 'company_event.dart';
import 'company_state.dart';
import '../../repositories/company_repository.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final CompanyRepository companyRepository;

  CompanyBloc(this.companyRepository) : super(CompanyLoading()) {
    on<FetchCompanies>(_onFetchCompanies);

    add(FetchCompanies());
  }

  Future<void> _onFetchCompanies(
      FetchCompanies event, Emitter<CompanyState> emit) async {
    try {
      emit(CompanyLoading());
      final companies = await companyRepository.fetchAllCompanies();
      emit(CompanyLoaded(companies));
    } catch (e) {
      emit(CompanyError(e.toString()));
    }
  }
}
