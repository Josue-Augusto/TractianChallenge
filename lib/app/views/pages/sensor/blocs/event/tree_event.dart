import 'package:tractian_tree/app/models/companies_model.dart';

abstract class TreeEvent {}

class AllAssetsTreeEvent extends TreeEvent {
  CompanyModel company;
  AllAssetsTreeEvent({required this.company});
}

class EnergyTreeEvent extends TreeEvent {
  CompanyModel company;
  EnergyTreeEvent({required this.company});
}

class CriticalTreeEvent extends TreeEvent {
  CompanyModel company;
  CriticalTreeEvent({required this.company});
}

class SearchTreeEvent extends TreeEvent {
  CompanyModel company;
  String query;
  SearchTreeEvent({required this.company, required this.query});
}
