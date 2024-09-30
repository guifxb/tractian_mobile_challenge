import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/node/node_bloc.dart';
import '../bloc/node/node_event.dart';
import '../utils/colors.dart';
import '../widgets/node_content.dart';

class AssetScreen extends StatelessWidget {
  final String companyId;

  const AssetScreen({super.key, required this.companyId});

  @override
  Widget build(BuildContext context) {
    context.read<NodeBloc>().add(FetchNodes(companyId));

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Assets",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            )),
        backgroundColor: backgroundTitle,
        centerTitle: true,
      ),
      body: const NodeContent(),
    );
  }
}
