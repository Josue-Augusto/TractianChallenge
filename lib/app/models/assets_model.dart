import 'dart:convert';

import 'package:flutter/material.dart';

class AssetsModel {
  String? gatewayId;
  String id;
  String? locationId;
  String name;
  String? parentId;
  String? sensorId;
  String? sensorType;
  String? status;
  List<AssetsModel> assets;
  ValueNotifier isExpanded;
  String icon;
  AssetsModel({
    required this.gatewayId,
    required this.id,
    required this.locationId,
    required this.name,
    this.parentId,
    required this.sensorId,
    required this.sensorType,
    required this.status,
    required this.assets,
    required this.icon,
    required this.isExpanded,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'gatewayId': gatewayId,
      'id': id,
      'locationId': locationId,
      'name': name,
      'parentId': parentId,
      'sensorId': sensorId,
      'sensorType': sensorType,
      'status': status,
    };
  }

  factory AssetsModel.fromMap(Map<String, dynamic> map) {
    return AssetsModel(
      gatewayId: map['gatewayId'] != null ? map['gatewayId'] as String : null,
      id: map['id'] as String,
      assets: [],
      isExpanded: ValueNotifier(false),
      icon: '',
      locationId:
          map['locationId'] != null ? map['locationId'] as String : null,
      name: map['name'] as String,
      parentId: map['parentId'] != null ? map['parentId'] as String : null,
      sensorId: map['sensorId'] != null ? map['sensorId'] as String : null,
      sensorType:
          map['sensorType'] != null ? map['sensorType'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssetsModel.fromJson(String source) =>
      AssetsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
