import 'package:tractian_tree/app/models/companies_model.dart';

abstract class TreeState {
  CompanyModel? company;
  String? error;

  TreeState({required this.company, this.error});
}

class TreeInitialState extends TreeState {
  TreeInitialState() : super(company: null);
}

class TreeLoadState extends TreeState {
  TreeLoadState() : super(company: null);
}

class TreeSuccessState extends TreeState {
  TreeSuccessState({required super.company});
}

class TreeEnergySuccessState extends TreeState {
  TreeEnergySuccessState({required super.company});
}

class TreeCriticalSuccessState extends TreeState {
  TreeCriticalSuccessState({required super.company});
}

class TreeSearchResultState extends TreeState {
  TreeSearchResultState({required super.company});
}

class TreeErrorState extends TreeState {
  TreeErrorState({required String error}) : super(company: null, error: error);
}
