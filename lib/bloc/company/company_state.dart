import 'package:equatable/equatable.dart';
import '../../models/company.dart';

abstract class CompanyState extends Equatable {
  const CompanyState();

  @override
  List<Object?> get props => [];
}

class CompanyLoading extends CompanyState {}

class CompanyLoaded extends CompanyState {
  final List<Company> companies;

  const CompanyLoaded(this.companies);

  @override
  List<Object?> get props => [companies];
}

class CompanyError extends CompanyState {
  final String message;

  const CompanyError(this.message);

  @override
  List<Object?> get props => [message];
}
