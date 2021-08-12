import 'dart:ui';

import 'package:film_fluent/core/constraints/app_keys.dart';
import 'package:film_fluent/core/constraints/state_enum.dart';
import 'package:film_fluent/core/utils/app_colors.dart';
import 'package:film_fluent/core/utils/text_themes.dart';
import 'package:film_fluent/feature/movie_list/data/models/movie_filter_model.dart';
import 'package:film_fluent/feature/movie_list/data/models/movie_list_model.dart';
import 'package:film_fluent/feature/movie_list/presentation/manager/MovieListcontroller.dart';
import 'package:film_fluent/feature/movie_list/presentation/widgets/custom_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieListPageRoute extends StatefulWidget {
  @override
  _MovieListPageRouteState createState() => _MovieListPageRouteState();
}

class _MovieListPageRouteState extends State<MovieListPageRoute> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MovieListController>(
        init: MovieListController(),
        builder: (controller){
          if(controller.state==StateEnum.loading)
            return Center(child: CircularProgressIndicator(),);
          else if(controller.state==StateEnum.success)
            return _movieList(controller.movieList);
          else
            return Container();
        },
      ),
      floatingActionButton: CustomFloatingActionButton(
        height: 300,
        onItemClick: _onFilterItemClicked,
        filterList: MovieFilterModel.sampleList,
      ),
    );
  }

  void _onFilterItemClicked(int index){

  }

  Widget _movieList(List<Results> results){
    return SafeArea(
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (_,index){
          return SizedBox(
            height: 300,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ImageFiltered(imageFilter:  ImageFilter.blur(sigmaY:2,sigmaX:2),
                child: Image.network('${AppKeys.imageBaseUrl}${results[index].posterPath}',width: Get.width,height: 300,fit: BoxFit.cover,),),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColor.GrayDarker
                          )
                        ),
                        child: Image.network('${AppKeys.imageBaseUrl}${results[index].posterPath}',fit: BoxFit.cover,)),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8,bottom: 12),
                    child: Container(

                      decoration: BoxDecoration(
                          color: AppColor.Green,
                        borderRadius: BorderRadius.all(Radius.circular(8))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(results[index].title,style: TextThemes.whiteNormal20,maxLines: 2,overflow: TextOverflow.fade,),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.White,
                        shape: BoxShape.circle
                      ),
                      child: Text(results[index].voteAverage.toString(),style:TextThemes.blackNormal17,),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
