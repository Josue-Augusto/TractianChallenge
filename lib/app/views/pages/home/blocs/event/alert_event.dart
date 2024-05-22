import 'package:tractian_tree/app/models/companies_model.dart';

abstract class AlertEvent {}

class LoadAlertEvent extends AlertEvent {
  List<CompanyModel> companies;
  LoadAlertEvent({required this.companies});
}
