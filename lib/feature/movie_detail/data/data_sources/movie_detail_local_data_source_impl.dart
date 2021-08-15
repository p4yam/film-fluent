
import 'package:film_fluent/core/constraints/app_keys.dart';
import 'package:film_fluent/feature/movie_list/data/models/movie_list_model.dart';
import 'package:hive/hive.dart';

import 'movie_detail_local_data_source.dart';

class MovieDetailLocalDataSourceImpl extends MovieDetailLocalDataSource{

  @override
  Future<bool> addRemoveMovieToDatabase(Movie movieModel) async{
    final hiveBox = await Hive.openBox(AppKeys.HiveBoxName);
    if(hiveBox.containsKey(movieModel.id)){
      hiveBox.delete(movieModel.id);
      return false;
    }else {
      hiveBox.put(movieModel.id, movieModel.toJson());
      return true;
    }
  }

  @override
  Future<bool> getMovieFavoriteStatus(int movieId) async{
    final hiveBox = await Hive.openBox(AppKeys.HiveBoxName);
    return hiveBox.containsKey(movieId);
  }

}