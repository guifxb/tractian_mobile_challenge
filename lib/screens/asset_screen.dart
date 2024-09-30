import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/asset/asset_bloc.dart';
import '../bloc/asset/asset_event.dart';
import '../bloc/asset/asset_state.dart';
import '../bloc/location/location_bloc.dart';
import '../bloc/location/location_event.dart';
import '../bloc/location/location_state.dart';
import '../utils/build_node_tree.dart';
import '../widgets/node_tile.dart';
import '../widgets/button_filter.dart';

import '../models/node.dart';

class AssetScreen extends StatefulWidget {
  final String companyId;

  const AssetScreen({super.key, required this.companyId});

  @override
  State<AssetScreen> createState() => _AssetScreenState();
}

class _AssetScreenState extends State<AssetScreen> {
  List<Node> _nodes = [];
  String _searchQuery = "";
  final List<bool> _filterSelection = [false, false, false, false];
  int _maxHierarchyLevel = 1;

  @override
  void initState() {
    super.initState();
    context.read<AssetBloc>().add(FetchAssets(widget.companyId));
    context.read<LocationBloc>().add(FetchLocations(widget.companyId));
  }

  void _buildNodeTree(AssetState assetState, LocationState locationState) async {
    if (assetState is AssetLoaded && locationState is LocationLoaded) {
      final nodes = await compute(
        buildNodeTreeWrapper,
        [assetState.assets, locationState.locations],
      );
      setState(() {
        _nodes = nodes;
      });
    }
  }

  List<Node> _applyFiltersAndSearch(List<Node> nodes) {
    List<Node> filteredNodes = [];

    for (var node in nodes) {
      final passesFilter = _passesFilter(node);
      final passesSearch = _passesSearch(node);

      final filteredChildren = _applyFiltersAndSearch(node.children);

      if (filteredChildren.isNotEmpty) {
        filteredNodes.add(node.copyWith(children: filteredChildren));
      } else if (passesFilter && passesSearch) {
        filteredNodes.add(node);
      }
    }

    return filteredNodes;
  }

  bool _passesFilter(Node node) {
    bool filterEnergy = !_filterSelection[0] || node.sensorType == "energy";
    bool filterVibration = !_filterSelection[1] || node.sensorType == "vibration";
    bool filterAlert = !_filterSelection[2] || node.status == "alert";
    bool filterOperating = !_filterSelection[3] || node.status == "operating";

    return filterEnergy && filterVibration && filterAlert && filterOperating;
  }

  bool _passesSearch(Node node) {
    return node.name.toLowerCase().contains(_searchQuery.toLowerCase());
  }

  void _onFilterButtonTapped(int index) {
    setState(() {
      _filterSelection[index] = !_filterSelection[index];
    });
  }

  void _updateMaxHierarchyLevel(int level) {
    setState(() {
      _maxHierarchyLevel = level;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assets"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: "Search location or asset",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AssetBloc, AssetState>(
            listener: (context, assetState) {
              _buildNodeTree(assetState, context.read<LocationBloc>().state);
            },
          ),
          BlocListener<LocationBloc, LocationState>(
            listener: (context, locationState) {
              _buildNodeTree(context.read<AssetBloc>().state, locationState);
            },
          ),
        ],
        child: BlocBuilder<AssetBloc, AssetState>(
          builder: (context, assetState) {
            return BlocBuilder<LocationBloc, LocationState>(
              builder: (context, locationState) {
                if (assetState is AssetLoading ||
                    locationState is LocationLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (assetState is AssetError ||
                    locationState is LocationError) {
                  return const Center(child: Text("Error loading data"));
                } else if (assetState is AssetLoaded &&
                    locationState is LocationLoaded) {
                  final filteredNodes = _applyFiltersAndSearch(_nodes);

                  final double calculatedWidth = MediaQuery.of(context).size.width +
                      (_maxHierarchyLevel * 40);

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: 3.4,
                          children: [
                            FilterButton(
                              buttonText: "Energy Sensor",
                              icon: Icons.bolt_outlined,
                              isSelected: _filterSelection[0],
                              onTap: () => _onFilterButtonTapped(0),
                            ),
                            FilterButton(
                              buttonText: "Vibration Sensor",
                              icon: Icons.vibration_outlined,
                              isSelected: _filterSelection[1],
                              onTap: () => _onFilterButtonTapped(1),
                            ),
                            FilterButton(
                              buttonText: "Alert",
                              icon: Icons.warning,
                              isSelected: _filterSelection[2],
                              onTap: () => _onFilterButtonTapped(2),
                            ),
                            FilterButton(
                              buttonText: "Operating",
                              icon: Icons.check_circle,
                              isSelected: _filterSelection[3],
                              onTap: () => _onFilterButtonTapped(3),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: calculatedWidth,
                                  maxWidth: calculatedWidth,
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: filteredNodes.length,
                                  itemBuilder: (context, index) {
                                    return NodeTile(
                                      node: filteredNodes[index],
                                      hierarchyLevel: 1,
                                      onExpansionChanged: _updateMaxHierarchyLevel,
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return const Center(child: Text("No data available"));
              },
            );
          },
        ),
      ),
    );
  }
}
