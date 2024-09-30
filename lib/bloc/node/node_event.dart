import 'package:equatable/equatable.dart';

abstract class NodeEvent extends Equatable {
  const NodeEvent();

  @override
  List<Object> get props => [];
}

class FetchNodes extends NodeEvent {
  final String companyId;

  const FetchNodes(this.companyId);

  @override
  List<Object> get props => [companyId];
}
