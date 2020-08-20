import 'package:bloc/bloc.dart';
import '../api/api_repository.dart';

abstract class DataState {}

class DataInitial extends DataState {}

class DataLoading extends DataState {}

class DataSuccess extends DataState {
  final List data;
  DataSuccess(this.data);
}

class DataFailed extends DataState {
  final String errorMessage;

  DataFailed(this.errorMessage);
}

class DataEvent {
  final String category;

  DataEvent(this.category);
}

class HomeBloc extends Bloc<DataEvent, DataState> {
  final ApiRepository apiRepository = ApiRepository();
  @override
  DataState get initialState => DataInitial();

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    yield DataLoading();
    final categoryNumber = event.category.toLowerCase();
    switch (categoryNumber) {
      case 'all':
        final data = await apiRepository.fetchPostedNews();
        if (data != null) {
          yield DataSuccess(data);
        } else {
          yield DataFailed('Jaribu tena');
        }
        break;
      case 'kimataifa':
        final data = await apiRepository.fetchInternationalNews();
        if (data != null) {
          yield DataSuccess(data);
        } else {
          yield DataFailed('Jaribu tena');
        }
        break;
      case 'kitaifa':
        final data = await apiRepository.fetchLocalNews();
        if (data != null) {
          yield DataSuccess(data);
        } else {
          yield DataFailed('Jaribu tena');
        }
        break;
      case 'mikoani':
        final data = await apiRepository.fetchRegionNews();
        if (data != null) {
          yield DataSuccess(data);
        } else {
          yield DataFailed('Jaribu tena');
        }
        break;
      case 'magazeti':
        final data = await apiRepository.fetchMagazetiNews();
        if (data != null) {
          yield DataSuccess(data);
        } else {
          yield DataFailed('Jaribu tena');
        }
        break;
      case 'michezo':
        final data = await apiRepository.fetchSportNews();
        if (data != null) {
          yield DataSuccess(data);
        } else {
          yield DataFailed('Jaribu tena');
        }
        break;
      case 'makala':
        final data = await apiRepository.fetchMkalaNews();
        if (data != null) {
          yield DataSuccess(data);
        } else {
          yield DataFailed('Jaribu tena');
        }
        break;
      default:
        yield DataFailed('Jaribu tena');
    }
  }
} 
