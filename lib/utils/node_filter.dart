import '../models/node.dart';

List<Node> applyFiltersAndSearch(
    List<Node> nodes, String searchQuery, List<bool> filterSelection) {
  List<Node> filteredNodes = [];

  for (var node in nodes) {
    final passesFilter = _passesFilter(node, filterSelection);
    final passesSearch = _passesSearch(node, searchQuery);

    final filteredChildren = applyFiltersAndSearch(node.children, searchQuery, filterSelection);

    if (filteredChildren.isNotEmpty) {
      filteredNodes.add(node.copyWith(children: filteredChildren));
    } else if (passesFilter && passesSearch) {
      filteredNodes.add(node);
    }
  }

  return filteredNodes;
}

bool _passesFilter(Node node, List<bool> filterSelection) {
  bool filterEnergy = !filterSelection[0] || node.sensorType == "energy";
  bool filterVibration = !filterSelection[1] || node.sensorType == "vibration";
  bool filterAlert = !filterSelection[2] || node.status == "alert";
  bool filterOperating = !filterSelection[3] || node.status == "operating";

  return filterEnergy && filterVibration && filterAlert && filterOperating;
}

bool _passesSearch(Node node, String searchQuery) {
  return node.name.toLowerCase().contains(searchQuery.toLowerCase());
}
