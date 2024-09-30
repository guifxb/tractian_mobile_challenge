import 'package:flutter/material.dart';
import '../models/node.dart';
import 'icon_sensor.dart';
import 'icon_status.dart';

class NodeTile extends StatefulWidget {
  final Node node;
  final int hierarchyLevel;
  final Function(int) onExpansionChanged;

  const NodeTile({
    super.key,
    required this.node,
    required this.hierarchyLevel,
    required this.onExpansionChanged,
  });

  @override
  _NodeTileState createState() => _NodeTileState();
}

class _NodeTileState extends State<NodeTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.only(
            left: 12 + (widget.hierarchyLevel * 25),
          ),
          leading: widget.node.children.isEmpty
              ? const SizedBox(width: 12)
              : Icon(
            _isExpanded
                ? Icons.arrow_downward_outlined
                : Icons.arrow_forward_outlined,
            size: 18,
          ),
          title: Row(
            children: [
              Image.asset(_getIconForNodeType(widget.node), height: 20, width: 20),
              const SizedBox(width: 10),
              Text(widget.node.name),
              if (widget.node.type == 'component') ...[
                const SizedBox(width: 10),
                SensorIcon(sensorType: widget.node.sensorType ?? ""),
                const SizedBox(width: 10),
                StatusIcon(status: widget.node.status ?? ""),
              ],
            ],
          ),
          onTap: widget.node.children.isNotEmpty
              ? () {
            setState(() {
              _isExpanded = !_isExpanded;
              if (_isExpanded) {
                widget.onExpansionChanged(widget.hierarchyLevel);
              } else {
                widget.onExpansionChanged(widget.hierarchyLevel - 1);
              }
            });
          }
              : null,
        ),
        if (_isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              children: widget.node.children.map((childNode) {
                return NodeTile(
                  node: childNode,
                  hierarchyLevel: widget.hierarchyLevel + 1,
                  onExpansionChanged: widget.onExpansionChanged,
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  String _getIconForNodeType(Node node) {
    if (node.type == 'location') {
      return 'lib/assets/images/location.png';
    } else if (node.type == 'asset') {
      return 'lib/assets/images/asset.png';
    } else if (node.type == 'component') {
      return 'lib/assets/images/component.png';
    } else {
      return 'lib/assets/images/default.png';
    }
  }
}
