import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tractian_tree/app/models/assets_model.dart';
import 'package:tractian_tree/app/views/tools/constants.dart';

abstract interface class ILocationRepository {
  Future<List<AssetsModel>> getLocatios({required String id});
}

class LocationRepository implements ILocationRepository {
  final List<AssetsModel> locations = [];
  @override
  Future<List<AssetsModel>> getLocatios({required String id}) async {
    final request =
        http.Request('GET', Uri.parse('$BASE_URL/companies/$id/locations'));
    final response = await request
        .send()
        .timeout(TIME_OUT, onTimeout: () => throw Exception('Timeout'));

    switch (response.statusCode) {
      case 200:
        final jsonString = await response.stream.bytesToString();
        final List<dynamic> maps = jsonDecode(jsonString);
        for (var map in maps) {
          locations.add(AssetsModel.fromMap(map));
        }
        return locations;
      case 404:
        throw Exception('Not found');

      default:
        throw Exception('Failed to load locations');
    }
  }
}
