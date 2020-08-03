import './api_provider.dart';

class ApiRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<List> fetchPostedNews() => _apiProvider.getPostedNews();
  Future<List> fetchSportNews() => _apiProvider.getSportNews();
  Future<List> fetchLocalNews() => _apiProvider.getLocalNews();
  Future<List> fetchInternationalNews() => _apiProvider.getInternationalNews();
  Future<List> fetchMagazetiNews() => _apiProvider.getMagazetiNews();
  Future<List> fetchMkalaNews() => _apiProvider.getMakalaNews();
  Future<List> fetchRegionNews() => _apiProvider.getRegionNews();
}
