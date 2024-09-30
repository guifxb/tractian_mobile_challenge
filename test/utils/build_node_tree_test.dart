import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_challenge/models/asset.dart';
import 'package:tractian_challenge/models/location.dart';
import 'package:tractian_challenge/utils/build_node_tree.dart';


void main() {
  group('buildNodeTree', () {
    test('should build tree with one location and one asset', () {
      final assets = [
        const Asset(id: 'a1', locationId: 'l1', name: 'Asset 1', parentId: '', sensorType: '', status: ''),
      ];
      final locations = [
        const Location(id: 'l1', name: 'Location 1', parentId: ""),
      ];

      final result = buildNodeTree(assets, locations);

      expect(result.length, 1);
      expect(result[0].name, 'Location 1');
      expect(result[0].children.length, 1);
      expect(result[0].children[0].name, 'Asset 1');
    });

    test('should build hierarchy with nested locations and assets', () {
      final assets = [
        const Asset(id: 'a1', locationId: 'l1', name: 'Asset 1', parentId: '', sensorType: '', status: ''),
        const Asset(id: 'a2', locationId: 'l2', name: 'Asset 2', parentId: '', sensorType: '', status: ''),
      ];
      final locations = [
        const Location(id: 'l1', name: 'Location 1', parentId: ""),
        const Location(id: 'l2', name: 'Sub-Location', parentId: 'l1'),
      ];

      final result = buildNodeTree(assets, locations);

      expect(result.length, 1);
      expect(result[0].name, 'Location 1');
      expect(result[0].children.length, 2);
      expect(result[0].children[0].name, 'Sub-Location');
      expect(result[0].children[0].children[0].name, 'Asset 2');
    });

    test('should sort nodes with children first', () {
      final assets = [
        const Asset(id: 'a1', locationId: '', name: 'Asset 1', parentId: '', sensorType: '', status: ''),
        const Asset(id: 'a2', locationId: 'l1', name: 'Asset 2', parentId: '', sensorType: '', status: ''),
      ];
      final locations = [
        const Location(id: 'l1', name: 'Location 1', parentId: ""),
      ];

      final result = buildNodeTree(assets, locations);

      expect(result[0].name, 'Location 1'); // Location with child
      expect(result[1].name, 'Asset 1'); // Node without children
    });

    test('should handle components correctly', () {
      final assets = [
        const Asset(id: 'c1', locationId: 'l1', name: 'Component 1', parentId: '', sensorType: 'vibration', status: 'operating'),
      ];
      final locations = [
        const Location(id: 'l1', name: 'Location 1', parentId: ""),
      ];

      final result = buildNodeTree(assets, locations);

      expect(result[0].children[0].name, 'Component 1');
      expect(result[0].children[0].type, 'component');
    });

    test('should build large tree efficiently', () {
      final List<Asset> assets = List.generate(100, (index) => Asset(
        id: 'a$index',
        locationId: index % 2 == 0 ? 'l1' : 'l2',
        name: 'Asset $index',
        parentId: '',
        sensorType: '',
        status: 'operating',
      ));
      final List<Location> locations = [
        const Location(id: 'l1', name: 'Location 1', parentId: ""),
        const Location(id: 'l2', name: 'Location 2', parentId: 'l1'),
      ];

      final result = buildNodeTree(assets, locations);

      expect(result.length, 1);
      expect(result[0].children.length, 51);
      expect(result[0].children[0].children.length, 50);
    });
  });
}
