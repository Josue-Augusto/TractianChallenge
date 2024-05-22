import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian_tree/app/models/assets_model.dart';
import 'package:tractian_tree/app/views/pages/home/blocs/event/alert_event.dart';
import 'package:tractian_tree/app/views/pages/home/blocs/state/alert_state.dart';

class AlertBloc extends Bloc<AlertEvent, AlertState> {
  AlertBloc() : super(AlertInitialState()) {
    on<LoadAlertEvent>((event, emit) async {
      final List<AssetsModel> warning = [];
      emit(AlertLoadState());
      if (event.companies.isNotEmpty) {
        for (var company in event.companies) {
          for (var asset in company.assets) {
            if (asset.sensorType != null && asset.status == 'alert') {
              warning.add(asset);
            }
          }
          for (var location in company.locations) {
            for (var subLocation in location.assets) {
              for (var assetCategory in subLocation.assets) {
                if (assetCategory.sensorType != null &&
                    assetCategory.status == 'alert') {
                  warning.add(assetCategory);
                }
                for (var assetSubCategory in assetCategory.assets) {
                  for (var componet in assetSubCategory.assets) {
                    if (componet.sensorType != null &&
                        componet.status == 'alert') {
                      warning.add(componet);
                    }
                  }
                }
              }
            }
          }
        }
      }
      emit(AlertSuccessState(warning: warning));
    });
  }
}
