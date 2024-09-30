import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/node/node_bloc.dart';
import '../bloc/node/node_state.dart';
import 'node_list_view.dart';

class NodeContent extends StatelessWidget {
  const NodeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NodeBloc, NodeState>(
      builder: (context, state) {
        if (state is NodeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NodeError) {
          return Center(child: Text("Error: ${state.message}"));
        } else if (state is NodeLoaded) {
          return NodeListView(nodes: state.nodes);
        }
        return const Center(child: Text("No data available"));
      },
    );
  }
}
