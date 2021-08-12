
import 'package:film_fluent/core/constraints/app_keys.dart';
import 'package:film_fluent/core/constraints/state_enum.dart';
import 'package:film_fluent/feature/movie_list/data/models/movie_filter_model.dart';
import 'package:film_fluent/feature/movie_list/domain/repositories/movie_list_repository.dart';
import 'package:get/get.dart';
import 'package:film_fluent/feature/movie_list/data/models/movie_list_model.dart';
import 'package:film_fluent/core/di/service_locator.dart' as di;
class MovieListController extends GetxController{

  final repository = di.getIt<MovieListRepository>();
  List<Results> movieList =[];
  MovieListModel currentModel;
  var state = StateEnum.initial;
  var sortBy = MovieFilterModel.sampleList[0];
  var _currentPage = 1;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData()async{
    state = StateEnum.loading;
    update();
    final result = await repository.fetchMovies({'api_key':AppKeys.ApiKey,'include_adult':'false','sort_by':sortBy.slug,'page':_currentPage});
    result.fold((l){
      print('p4yam: ${l.message}');
    }, (r){
      state=StateEnum.success;
      currentModel= r;
      movieList= r.results;
      update();
      print('p4yam: success ${r.results.length}');
    });
  }
}