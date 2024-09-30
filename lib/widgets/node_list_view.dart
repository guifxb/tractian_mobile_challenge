import 'package:flutter/material.dart';
import '../models/node.dart';
import '../utils/node_filter.dart';
import 'grid_filter_buttons.dart';
import 'node_tile.dart';

class NodeListView extends StatefulWidget {
  final List<Node> nodes;

  const NodeListView({super.key, required this.nodes});

  @override
  NodeListViewState createState() => NodeListViewState();
}

class NodeListViewState extends State<NodeListView> {
  String _searchQuery = "";
  final List<bool> _filterSelection = [false, false, false, false];
  int _maxHierarchyLevel = 1;

  void _onSearchQueryChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _updateMaxHierarchyLevel(int level) {
    setState(() {
      _maxHierarchyLevel = level;
    });
  }

  void _onFilterButtonTapped(int index) {
    setState(() {
      _filterSelection[index] = !_filterSelection[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredNodes = applyFiltersAndSearch(
      widget.nodes,
      _searchQuery,
      _filterSelection,
    );

    final double calculatedWidth = MediaQuery.of(context).size.width +
        (_maxHierarchyLevel * 40);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              labelText: "Search location or asset",
              border: OutlineInputBorder(),
            ),
            onChanged: _onSearchQueryChanged,
          ),
        ),
        GridFilterButtons(
          filterSelection: _filterSelection,
          onFilterButtonTapped: _onFilterButtonTapped,
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
}
