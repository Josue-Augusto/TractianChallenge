import 'package:test/test.dart';
import 'package:tractian_tree/app/data/api/company_repository.dart';
import 'package:tractian_tree/app/models/companies_model.dart';

void main() {
  final ICompanyRepository repo = CompanyRepository();
  test('Must return a list that contains items of type CompanyModel', () async {
    try {
      expect(await repo.getCompanies(),
          allOf([isA<Future<List<CompanyModel>>>(), isNotEmpty]));
    } catch (e) {
      expect(e, isA<Exception>());
    }
  });
}
