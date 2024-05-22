import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian_tree/app/models/assets_model.dart';
import 'package:tractian_tree/app/models/companies_model.dart';
import 'package:tractian_tree/app/views/pages/sensor/blocs/event/tree_event.dart';
import 'package:tractian_tree/app/views/pages/sensor/blocs/state/tree_state.dart';

class TreeBloc extends Bloc<TreeEvent, TreeState> {
  TreeBloc() : super(TreeInitialState()) {
    on<AllAssetsTreeEvent>((event, emit) async {
      emit(TreeSuccessState(company: event.company));
    });

    on<EnergyTreeEvent>((event, emit) async {
      final CompanyModel company = CompanyModel(
          id: event.company.id, name: 'Energy', locations: [], assets: []);

      for (var location in event.company.locations) {
        for (var subLocation in location.assets) {
          for (var asset in subLocation.assets) {
            if (asset.sensorType == 'energy') {
              if (!company.locations.contains(location)) {
                company.locations.add(location);
              }
            }
            for (var subAsset in asset.assets) {
              for (var componet in subAsset.assets) {
                if (componet.sensorType == 'energy') {
                  if (!company.locations.contains(location)) {
                    company.locations.add(location);
                  }
                }
              }
            }
          }
        }
        for (var asset in location.assets) {
          if (asset.sensorType == 'energy') {
            if (!company.locations.contains(location)) {
              company.locations.add(location);
            }
          }
        }
      }

      for (var asset in event.company.assets) {
        if (asset.sensorType == 'energy') {
          if (!company.assets.contains(asset)) {
            company.assets.add(asset);
          }
        }
      }

      final List<AssetsModel> locationsCopy = List.from(company.locations);

      for (var location in locationsCopy) {
        for (var subLocation in location.assets) {
          subLocation.assets
              .removeWhere((asset) => asset.sensorType != 'energy');
          for (var asset in subLocation.assets) {
            asset.assets.removeWhere((asset) => asset.sensorType != 'energy');
            for (var subAsset in asset.assets) {
              subAsset.assets
                  .removeWhere((componet) => componet.sensorType != 'energy');
            }
          }
        }
      }
      for (var location in locationsCopy) {
        location.assets.removeWhere((asset) => asset.assets.isEmpty);
      }
      company.locations = locationsCopy;

      emit(TreeEnergySuccessState(company: company));
    });

    on<CriticalTreeEvent>((event, emit) async {
      final CompanyModel company = CompanyModel(
          id: event.company.id, name: 'Critical', locations: [], assets: []);

      for (var location in event.company.locations) {
        for (var subLocation in location.assets) {
          for (var asset in subLocation.assets) {
            if (asset.status == 'alert') {
              if (!company.locations.contains(location)) {
                company.locations.add(location);
              }
            }
            for (var subAsset in asset.assets) {
              for (var componet in subAsset.assets) {
                if (componet.status == 'alert') {
                  if (!company.locations.contains(location)) {
                    company.locations.add(location);
                  }
                }
              }
            }
          }
        }
        for (var asset in location.assets) {
          if (asset.status == 'alert') {
            if (!company.locations.contains(location)) {
              company.locations.add(location);
            }
          }
        }
      }

      for (var asset in event.company.assets) {
        if (asset.status == 'alert') {
          if (!company.assets.contains(asset)) {
            company.assets.add(asset);
          }
        }
      }

      final List<AssetsModel> locationsCopy = List.from(company.locations);

      for (var location in locationsCopy) {
        for (var subLocation in location.assets) {
          subLocation.assets.removeWhere((asset) => asset.status != 'alert');
          for (var asset in subLocation.assets) {
            asset.assets.removeWhere((asset) => asset.status != 'alert');
            for (var subAsset in asset.assets) {
              subAsset.assets
                  .removeWhere((componet) => componet.status != 'alert');
            }
          }
        }
      }
      for (var location in locationsCopy) {
        location.assets.removeWhere((asset) => asset.assets.isEmpty);
      }
      company.locations = locationsCopy;

      emit(TreeCriticalSuccessState(company: company));
    });

    on<SearchTreeEvent>((event, emit) async {
      final CompanyModel company = CompanyModel(
          id: event.company.id,
          name: event.company.name,
          locations: [],
          assets: []);
      for (var location in event.company.locations) {
        if (location.name.toLowerCase().contains(event.query.toLowerCase())) {
          if (!company.locations.contains(location)) {
            company.locations.add(location);
          }
        } else {
          for (var asset in location.assets) {
            if (asset.name.toLowerCase().contains(event.query.toLowerCase()) &&
                asset.sensorType != null) {
              if (!company.locations.contains(location)) {
                company.locations.add(location);
              }
            }
          }
        }

        for (var subLocation in location.assets) {
          for (var asset in subLocation.assets) {
            if (asset.name.toLowerCase().contains(event.query.toLowerCase()) &&
                asset.sensorType != null) {
              if (!company.locations.contains(location)) {
                company.locations.add(location);
              }
            }
            for (var subAsset in asset.assets) {
              for (var componet in subAsset.assets) {
                if (componet.name
                    .toLowerCase()
                    .contains(event.query.toLowerCase())) {
                  if (!company.locations.contains(location)) {
                    company.locations.add(location);
                  }
                }
              }
            }
          }
        }
      }

      for (var asset in event.company.assets) {
        if (asset.name.toLowerCase().contains(event.query.toLowerCase())) {
          company.assets.add(asset);
        }
      }

      emit(TreeSearchResultState(company: company));
    });
  }
}
