import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tractian_tree/app/data/api/assets_repository.dart';
import 'package:tractian_tree/app/data/api/locations_repository.dart';
import 'package:tractian_tree/app/models/assets_model.dart';
import 'package:tractian_tree/app/models/companies_model.dart';
import 'package:tractian_tree/app/views/tools/constants.dart';

abstract interface class ICompanyRepository {
  Future<List<CompanyModel>> getCompanies();
}

class CompanyRepository implements ICompanyRepository {
  final List<CompanyModel> _companies = [];
  final IAssetsRepository assetsRepo = AssetsRepository();
  final ILocationRepository locationRepo = LocationRepository();

  @override
  Future<List<CompanyModel>> getCompanies() async {
    final request = http.Request('GET', Uri.parse('$BASE_URL/companies'));
    final response = await request
        .send()
        .timeout(TIME_OUT, onTimeout: () => throw Exception('Timeout'));

    switch (response.statusCode) {
      case 200:
        final jsonString = await response.stream.bytesToString();
        final List<dynamic> maps = jsonDecode(jsonString);
        for (var map in maps) {
          _companies.add(CompanyModel.fromMap(map));
        }
        await _locationsAndSubLocations();
        return _companies;
      case 404:
        throw Exception('Not found');

      default:
        throw Exception('Failed to load companies');
    }
  }

  Future<void> _locationsAndSubLocations() async {
    for (var company in _companies) {
      final allLocations = await locationRepo.getLocatios(id: company.id);

      final List<AssetsModel> locations = [];

      for (var location in allLocations) {
        if (location.parentId == null) {
          location.icon = 'location.png';
          locations.add(location);
        }
      }
      for (var location in locations) {
        for (var sub in allLocations) {
          if (location.id == sub.parentId) {
            if (!location.assets.contains(sub)) {
              sub.icon = 'location.png';
              location.assets.add(sub);
            }
          }
        }
      }
      company.locations = locations;
    }
    await _assetsAndSubAssets();
  }

  Future<void> _assetsAndSubAssets() async {
    final List<AssetsModel> allAssets = [];
    for (var company in _companies) {
      final assets = await assetsRepo.getAssets(comapanyid: company.id);
      for (var asset in assets) {
        allAssets.add(asset);
      }
    }
    for (var company in _companies) {
      for (var location in company.locations) {
        for (var asset in allAssets) {
          // add assets in root
          if (asset.locationId == null &&
              asset.parentId == null &&
              asset.sensorType != null) {
            if (!company.assets.contains(asset)) {
              asset.icon =
                  asset.sensorType != null ? 'component.png' : 'asset.png';
              company.assets.add(asset);
            }
          }

          // add assets
          for (var localAsset in company.locations) {
            if (asset.locationId != null &&
                asset.sensorId == null &&
                localAsset.id == asset.locationId) {
              if (!localAsset.assets.contains(asset)) {
                if (asset.parentId == null) {
                  asset.icon = 'asset.png';
                  localAsset.assets.add(asset);
                }
              }
            }
          }
          // assets in subLocations
          for (var subLocation in location.assets) {
            // add subAssets
            if (asset.locationId != null &&
                asset.sensorId == null &&
                subLocation.id == asset.locationId) {
              if (!subLocation.assets.contains(asset)) {
                if (asset.parentId == null) {
                  asset.icon = 'asset.png';
                  subLocation.assets.add(asset);
                }
              }
            }
            if (subLocation.id == asset.locationId &&
                asset.sensorType != null &&
                asset.parentId == null) {
              if (!subLocation.assets.contains(asset)) {
                asset.icon = 'component.png';
                subLocation.assets.add(asset);
              }
            }
          }
        }
      }

      // subAssets
      for (var location in company.locations) {
        for (var subLocation in location.assets) {
          for (var asset in allAssets) {
            if (asset.parentId == subLocation.id && asset.sensorType != null) {
              if (!subLocation.assets.contains(asset)) {
                asset.icon = 'component.png';
                subLocation.assets.add(asset);
              }
            }
          }
          for (var assetCategory in subLocation.assets) {
            for (var asset in allAssets) {
              if (asset.parentId == assetCategory.id &&
                  asset.sensorId == null) {
                if (!assetCategory.assets.contains(asset)) {
                  asset.icon = 'asset.png';
                  assetCategory.assets.add(asset);
                }
              }
            }
          }
        }
      }

      // add componet
      for (var location in company.locations) {
        for (var subLocation in location.assets) {
          for (var assetCategory in subLocation.assets) {
            for (var compnet in assetCategory.assets) {
              for (var asset in allAssets) {
                if (asset.parentId == compnet.id && asset.sensorType != null) {
                  if (!compnet.assets.contains(asset)) {
                    asset.icon = 'component.png';
                    compnet.assets.add(asset);
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
