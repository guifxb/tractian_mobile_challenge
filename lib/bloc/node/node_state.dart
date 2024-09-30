import 'package:equatable/equatable.dart';
import '../../models/node.dart';

abstract class NodeState extends Equatable {
  const NodeState();

  @override
  List<Object?> get props => [];
}

class NodeLoading extends NodeState {}

class NodeLoaded extends NodeState {
  final List<Node> nodes;

  const NodeLoaded(this.nodes);

  @override
  List<Object?> get props => [nodes];
}

class NodeError extends NodeState {
  final String message;

  const NodeError(this.message);

  @override
  List<Object?> get props => [message];
}
