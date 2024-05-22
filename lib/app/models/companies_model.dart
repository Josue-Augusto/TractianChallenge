import 'dart:convert';

import 'package:tractian_tree/app/models/assets_model.dart';

class CompanyModel {
  String id;
  String name;
  List<AssetsModel> locations;
  List<AssetsModel> assets;
  CompanyModel({
    required this.id,
    required this.name,
    required this.locations,
    required this.assets,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'locations': locations.map((x) => x.toMap()).toList(),
    };
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      id: map['id'] as String,
      name: map['name'] as String,
      assets: [],
      locations: map['locations'] == null
          ? []
          : List<AssetsModel>.from(
              (map['locations'] as List<int>).map<AssetsModel>(
                (x) => AssetsModel.fromMap(x as Map<String, dynamic>),
              ),
            ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyModel.fromJson(String source) =>
      CompanyModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
