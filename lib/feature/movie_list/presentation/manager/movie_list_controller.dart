import 'package:film_fluent/core/constraints/app_keys.dart';
import 'package:film_fluent/core/constraints/state_enum.dart';
import 'package:film_fluent/feature/movie_list/data/models/movie_filter_model.dart';
import 'package:film_fluent/feature/movie_list/domain/repositories/movie_list_repository.dart';
import 'package:get/get.dart';
import 'package:film_fluent/feature/movie_list/data/models/movie_list_model.dart';
import 'package:film_fluent/core/di/service_locator.dart' as di;
import 'dart:developer' as developer;
class MovieListController extends GetxController {
  /// injecting dependencies instead of creating multiple new items
  /// GetX dependency injection has some problems with [PageView]
  /// so I used [get_it] package alongside
  final repository = di.getIt<MovieListRepository>();

  List<Movie> _movieList = [];
  List<Movie> get movieList => _movieList;
  MovieListModel currentModel;
  var state = StateEnum.initial;
  var _currentPage = 1;

  var _errorMessage = '';
  String get errorMessage => _errorMessage;

  var searchString = '';

  /// fetching data from server, the input values are:
  /// [refreshFilter] shows that if we want to rebuild the list or just add more
  /// data to the existing [_movieList]
  /// [query] is mainly the search string to be added to our Map.
  void fetchData(bool refreshFilter, String query) async {
    state = !refreshFilter ? StateEnum.loadMore : StateEnum.loading;
    if (refreshFilter) {
      _currentPage = 1;
      _movieList.clear();
      currentModel = null;
    }
    update();
    final result = await repository.fetchMovies({
      'api_key': AppKeys.ApiKey,
      'include_adult': 'false',
      'page': _currentPage,
      'query': query
    });
    result.fold((l) {
      state = StateEnum.error;
      _errorMessage = l.message;
      update();
    }, (r) {
      state = StateEnum.success;
      currentModel = r;
      if (r.results != null) {
        _movieList.addAll(r.results);
        _currentPage += 1;
      }
      update();
    });
  }


  /// Sorting previously filled [_movieList]
  /// Some movies may have blank Release Date, so instead of showing
  /// an error, this method will return the previous data.
  void sortMovies(MovieFilterModel sortType) async{
    state = StateEnum.loading;
    update();
    await Future.delayed(Duration(seconds: 1));
    switch (sortType.slug) {
      case 'popularity.desc':
        _movieList.sort((a, b) => b.popularity.compareTo(a.popularity));
        break;
      case 'popularity.asc':
        _movieList.sort((a, b) => a.popularity.compareTo(b.popularity));
        break;
      case 'vote_count.desc':
        _movieList.sort((a, b) => b.voteCount.compareTo(a.voteCount));
        break;
      case 'vote_count.asc':
        _movieList.sort((a, b) => a.voteCount.compareTo(b.voteCount));
        break;
      case 'release_date.desc':
        try {
          _movieList.sort((a, b) => DateTime.tryParse(b.releaseDate)
              .compareTo(DateTime.tryParse(a.releaseDate)));
        } catch (ignored) {
          developer.log(ignored.toString());
        }
        break;
      case 'release_date.asc':
        try {
          _movieList.sort((a, b) => DateTime.tryParse(a.releaseDate)
              .compareTo(DateTime.tryParse(b.releaseDate)));
        } catch (ignored) {
          developer.log(ignored.toString());
        }
        break;
      default:
        break;
    }
    state = StateEnum.success;
    update();
  }
}
