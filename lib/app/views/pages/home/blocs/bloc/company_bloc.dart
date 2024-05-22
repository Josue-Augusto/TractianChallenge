import 'package:bloc/bloc.dart';
import 'package:tractian_tree/app/data/api/company_repository.dart';
import 'package:tractian_tree/app/views/pages/home/blocs/event/comapny_event.dart';
import 'package:tractian_tree/app/views/pages/home/blocs/state/company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final ICompanyRepository _repo = CompanyRepository();

  CompanyBloc() : super(CompanyInitialState()) {
    on<LoadCompanyEvent>((event, emit) async {
      try {
        emit(CompanyLoadState());
        final companies = await _repo.getCompanies();
        emit(CompanySuccessState(companies: companies));
      } catch (e) {
        emit(CompanyErrorState(error: '$e, try again later.'));
      }
    });
  }
}
