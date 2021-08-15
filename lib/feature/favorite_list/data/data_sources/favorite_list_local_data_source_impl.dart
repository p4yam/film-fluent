
import 'package:film_fluent/core/constraints/app_keys.dart';
import 'package:film_fluent/feature/favorite_list/data/data_sources/favorite_list_local_data_source.dart';
import 'package:film_fluent/feature/movie_list/data/models/movie_list_model.dart';
import 'package:hive/hive.dart';

class FavoriteListLocalDataSourceImpl extends FavoriteListLocalDataSource{

  @override
  Future<Iterable<dynamic>> fetchMoviesFromDB() async{
    final hiveBox = await Hive.openBox(AppKeys.HiveBoxName);
    return hiveBox.values;
  }
}