import 'package:film_fluent/core/constraints/app_constraints.dart';
import 'package:film_fluent/core/constraints/state_enum.dart';
import 'package:film_fluent/core/widgets/error_widget.dart';
import 'package:film_fluent/core/widgets/movie_list_item.dart';
import 'package:film_fluent/feature/favorite_list/presentation/manager/favorite_list_controller.dart';
import 'package:film_fluent/feature/movie_detail/presentation/pages/movie_detail_page_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteListPageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoriteListController>(
      init: FavoriteListController(),
      builder: (controller){
        return Scaffold(
          appBar: AppBar(
            title: Text(AppConstraints.NavBarFavorite),
          ),
          body: _buildBody( controller),
        );
      },
    );
  }

  Widget _buildBody(FavoriteListController controller){
    if (controller.state == StateEnum.initial)
      return CustomErrorWidget(
        buttonWidth: Get.width / 3,
        errorMessage: AppConstraints.EmptySearch,
        imagePath: 'assets/images/undraw_searching_p5ux.svg',
        showRefreshButton: false,
        imageWidth: Get.width / 2,
        onRefreshClicked: () {},
      );
    else if (controller.state == StateEnum.loading)
      return Center(
        child: CircularProgressIndicator(),
      );
    else if (controller.state == StateEnum.success ||
        controller.state == StateEnum.loadMore) {
      return _movieList(controller);
    } else
      return CustomErrorWidget(
        buttonWidth: Get.width / 3,
        errorMessage: controller.errorMessage.toString(),
        imagePath: 'assets/images/undraw_Location_search_re_ttoj.svg',
        showRefreshButton: true,
        imageWidth: Get.width / 2,
        onRefreshClicked: () {
          controller.fetchMoviesFromDB();
        },
      );
  }

  Widget _movieList(FavoriteListController controller) {
    final results = controller.movieList;
    if(results.length>0)
      return ListView.builder(
        itemCount: results.length,
        itemBuilder: (_, index) {
          return Hero(
            tag: 'f${results[index].id}',
            child: MovieListItem(
              result: results[index],
              onClick: () async{
                await Get.to(()=>MovieDetailPageRoute(movieItem: results[index],heroTag: 'f${results[index].id}',));
                controller.fetchMoviesFromDB();
              },
            ),
          );
        },
      );
    return CustomErrorWidget(
      buttonWidth: Get.width / 3,
      errorMessage: AppConstraints.FavListEmpty,
      imagePath: 'assets/images/undraw_searching_p5ux.svg',
      showRefreshButton: false,
      imageWidth: Get.width / 2,
      onRefreshClicked: () {},
    );
  }
}
