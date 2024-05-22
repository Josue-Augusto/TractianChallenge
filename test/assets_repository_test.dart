import 'package:test/test.dart';
import 'package:tractian_tree/app/data/api/assets_repository.dart';
import 'package:tractian_tree/app/models/assets_model.dart';

void main() {
  final IAssetsRepository repo = AssetsRepository();

  test('Must contain a list of AssetsModel and cannot be empty', () async {
    try {
      expect(await repo.getAssets(comapanyid: '662fd0fab3fd5656edb39af5'),
          allOf([isA<List<AssetsModel>>(), isNotEmpty]));
    } catch (e) {
      expect(e, isA<Exception>());
    }
  });
}
