import 'package:tractian_tree/app/models/companies_model.dart';

abstract class CompanyState {
  List<CompanyModel> companies;
  String? error;

  CompanyState({required this.companies, this.error});
}

class CompanyInitialState extends CompanyState {
  CompanyInitialState() : super(companies: []);
}

class CompanyLoadState extends CompanyState {
  CompanyLoadState() : super(companies: []);
}

class CompanySuccessState extends CompanyState {
  CompanySuccessState({required super.companies});
}

class CompanyErrorState extends CompanyState {
  CompanyErrorState({required String error})
      : super(companies: [], error: error);
}
