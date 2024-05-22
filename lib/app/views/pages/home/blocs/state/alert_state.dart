import 'package:tractian_tree/app/models/assets_model.dart';

abstract class AlertState {
  List<AssetsModel> warning;
  String? error;

  AlertState({required this.warning, this.error});
}

class AlertInitialState extends AlertState {
  AlertInitialState() : super(warning: []);
}

class AlertLoadState extends AlertState {
  AlertLoadState() : super(warning: []);
}

class AlertSuccessState extends AlertState {
  AlertSuccessState({required super.warning});
}

class AlertErrorState extends AlertState {
  AlertErrorState({required String error}) : super(warning: [], error: error);
}
