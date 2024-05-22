import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_tree/app/data/api/locations_repository.dart';
import 'package:tractian_tree/app/models/assets_model.dart';

void main() {
  final ILocationRepository repo = LocationRepository();

  test('Must contain a list of LocationModel and cannot be empty', () async {
    try {
      final list = await repo.getLocatios(id: '662fd0fab3fd5656edb39af5');
      expect(list, allOf([isA<List<AssetsModel>>(), isNotEmpty]));
    } catch (e) {
      expect(e, isA<Exception>());
    }
  });
}
