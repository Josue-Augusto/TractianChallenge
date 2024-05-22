import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tractian_tree/app/models/assets_model.dart';
import 'package:tractian_tree/app/views/tools/constants.dart';

abstract class IAssetsRepository {
  Future<List<AssetsModel>> getAssets({required String comapanyid});
}

class AssetsRepository implements IAssetsRepository {
  final List<AssetsModel> _assets = [];
  @override
  Future<List<AssetsModel>> getAssets({required String comapanyid}) async {
    final request = http.Request(
        'GET', Uri.parse('$BASE_URL/companies/$comapanyid/assets'));
    final response = await request
        .send()
        .timeout(TIME_OUT, onTimeout: () => throw Exception('Timeout'));

    switch (response.statusCode) {
      case 200:
        final jsonString = await response.stream.bytesToString();
        final List<dynamic> maps = jsonDecode(jsonString);
        for (var map in maps) {
          _assets.add(AssetsModel.fromMap(map));
        }
        return _assets;
      case 404:
        throw Exception('Not found');

      default:
        throw Exception('Failed to load assets');
    }
  }
}
