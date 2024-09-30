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
  final Map<String, List<Node>> locationChildren = {};
  final Map<String, List<Node>> assetChildren = {};

  for (var location in locations) {
    final node = Node(
      id: location.id,
      name: location.name,
      type: 'location',
      children: [],
      hierarchyLevel: 0,
    );
    nodeMap[location.id] = node;
    locationChildren[location.parentId ?? ''] = [...(locationChildren[location.parentId ?? ''] ?? []), node];
  }

  for (var asset in assets) {
    bool isComponent = asset.sensorType != "";
    final node = Node(
      id: asset.id,
      name: asset.name,
      type: isComponent ? 'component' : 'asset',
      status: asset.status,
      sensorType: asset.sensorType,
      children: [],
      hierarchyLevel: 0,
    );
    nodeMap[asset.id] = node;

    if (asset.locationId.isNotEmpty) {
      locationChildren[asset.locationId] = [...(locationChildren[asset.locationId] ?? []), node];
    }
    if (asset.parentId.isNotEmpty) {
      assetChildren[asset.parentId] = [...(assetChildren[asset.parentId] ?? []), node];
    }
  }

  void addChildren(Node parentNode, int hierarchyLevel) {
    parentNode.hierarchyLevel = hierarchyLevel;

    final childrenFromLocations = locationChildren[parentNode.id] ?? [];
    final childrenFromAssets = assetChildren[parentNode.id] ?? [];

    parentNode.children.addAll(childrenFromLocations);
    parentNode.children.addAll(childrenFromAssets);

    for (var child in parentNode.children) {
      addChildren(child, hierarchyLevel + 1);
    }

    parentNode.children.sort((a, b) {
      if (a.children.isNotEmpty && b.children.isEmpty) return -1;
      if (a.children.isEmpty && b.children.isNotEmpty) return 1;
      return compareNodeTypes(a, b);
    });
  }

  List<Node> rootNodes = [];

  for (var location in locations) {
    if (location.parentId == "" || location.parentId.isEmpty) {
      var rootNode = nodeMap[location.id]!;
      addChildren(rootNode, 1);
      rootNodes.add(rootNode);
    }
  }

  for (var asset in assets) {
    if (asset.parentId.isEmpty && asset.locationId.isEmpty) {
      var rootNode = nodeMap[asset.id]!;
      addChildren(rootNode, 1);
      rootNodes.add(rootNode);
    }
  }

  rootNodes.sort((a, b) {
    if (a.children.isNotEmpty && b.children.isEmpty) return -1;
    if (a.children.isEmpty && b.children.isNotEmpty) return 1;
    return compareNodeTypes(a, b);
  });

  return rootNodes;
}

int compareNodeTypes(Node a, Node b) {
  final order = {'location': 0, 'asset': 1, 'component': 2};
  return order[a.type]!.compareTo(order[b.type]!);
}
