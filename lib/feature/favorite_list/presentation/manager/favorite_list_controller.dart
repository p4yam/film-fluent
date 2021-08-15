
import 'package:film_fluent/core/constraints/state_enum.dart';
import 'package:film_fluent/feature/favorite_list/domain/repositories/favorite_list_repository.dart';
import 'package:film_fluent/feature/movie_list/data/models/movie_list_model.dart';
import 'package:get/get.dart';
import 'package:film_fluent/core/di/service_locator.dart' as di;

class FavoriteListController extends GetxController{

  /// injecting dependencies instead of creating multiple new items
  /// GetX dependency injection has some problems with [PageView]
  /// so I used [get_it] package alongside
  final repository = di.getIt<FavoriteListRepository>();
  List<Movie> _movieList = [];
  List<Movie> get movieList => _movieList;
  var state = StateEnum.initial;
  var _errorMessage = '';
  String get errorMessage => _errorMessage;

  @override
  void onInit() {
    fetchMoviesFromDB();
    super.onInit();
  }


  void fetchMoviesFromDB()async{
    state = StateEnum.loading;
    update();
    final result =await repository.fetchMoviesFromDB();
    result.fold((l) {
      _errorMessage=l.message;
      state=StateEnum.error;
    }, (r) {
      _movieList=r;
      state=StateEnum.success;
    });
    update();

  }

}