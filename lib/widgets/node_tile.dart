import 'package:flutter/material.dart';
import '../models/node.dart';
import 'icon_sensor.dart';
import 'icon_status.dart';

class NodeTile extends StatefulWidget {
  final Node node;

  const NodeTile({super.key, required this.node});

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
          contentPadding: EdgeInsets.only(left: widget.node.hierarchyLevel * 16.0),
          leading: widget.node.children.isEmpty ? null : Icon(
            _isExpanded ? Icons.keyboard_arrow_down : Icons.arrow_forward_ios,
          ),
          title: Row(
            children: [
              Image.asset(_getIconForNodeType(widget.node), height: 20, width: 20),
              SizedBox(width: 10),
              Text(widget.node.name),
              if (widget.node.type == 'component') ...[
                SizedBox(width: 10),
                SensorIcon(sensorType: widget.node.sensorType ?? ""),
                SizedBox(width: 10),
                StatusIcon(status: widget.node.status ?? ""),
              ],
            ],
          ),
          onTap: widget.node.children.isNotEmpty
              ? () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          }
              : null,
        ),
        if (_isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              children: widget.node.children.map((childNode) {
                return NodeTile(node: childNode);
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
