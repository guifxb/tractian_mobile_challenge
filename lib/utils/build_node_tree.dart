import '../models/asset.dart';
import '../models/location.dart';
import '../models/node.dart';

List<Node> buildNodeTreeWrapper(List<dynamic> args) {
  final assets = args[0] as List<Asset>;
  final locations = args[1] as List<Location>;
  return buildNodeTree(assets, locations);
}

List<Node> buildNodeTree(List<Asset> assets, List<Location> locations) {
  final Map<String, Node> nodeMap = {};

  for (var location in locations) {
    nodeMap[location.id] = Node(
      id: location.id,
      name: location.name,
      type: 'location',
      children: [],
      hierarchyLevel: 0,
    );
  }

  for (var asset in assets) {
    bool isComponent = asset.sensorType != "";
    nodeMap[asset.id] = Node(
      id: asset.id,
      name: asset.name,
      type: isComponent ? 'component' : 'asset',
      status: asset.status,
      sensorType: asset.sensorType,
      children: [],
      hierarchyLevel: 0,
    );
  }

  void addChildren(Node parentNode) {
    for (var asset in assets) {
      if (asset.parentId == parentNode.id || asset.locationId == parentNode.id) {
        var childNode = nodeMap[asset.id]!.copyWith(
          hierarchyLevel: parentNode.hierarchyLevel + 1,
        );
        parentNode.children.add(childNode);
        addChildren(childNode);
      }
    }

    for (var location in locations) {
      if (location.parentId == parentNode.id) {
        var childNode = nodeMap[location.id]!.copyWith(
          hierarchyLevel: parentNode.hierarchyLevel + 1,
        );
        parentNode.children.add(childNode);
        addChildren(childNode);
      }
    }
  }

  List<Node> rootNodes = [];

  for (var location in locations) {
    if (location.parentId == "") {
      var rootNode = nodeMap[location.id]!;
      addChildren(rootNode);
      rootNodes.add(rootNode);
    }
  }

  for (var asset in assets) {
    if (asset.parentId == "" && asset.locationId == "") {
      var rootNode = nodeMap[asset.id]!;
      addChildren(rootNode);
      rootNodes.add(rootNode);
    }
  }

  List<Node> sortedNodes = [];
  for (var node in rootNodes) {
    sortedNodes.add(node);
  }

  List<Node> nodesWithChildren = [];
  List<Node> nodesWithoutChildren = [];

  for (var node in sortedNodes) {
    if (node.children.isNotEmpty) {
      nodesWithChildren.add(node);
    } else {
      nodesWithoutChildren.add(node);
    }
  }

  return [...nodesWithChildren, ...nodesWithoutChildren];
}

int compareNodeTypes(Node a, Node b) {
  final order = {'location': 0, 'asset': 1, 'component': 2};
  return order[a.type]!.compareTo(order[b.type]!);
}
