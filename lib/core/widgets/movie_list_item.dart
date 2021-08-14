import 'dart:ui';

import 'package:film_fluent/core/constraints/app_keys.dart';
import 'package:film_fluent/core/utils/app_colors.dart';
import 'package:film_fluent/core/utils/text_themes.dart';
import 'package:film_fluent/feature/movie_list/data/models/movie_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieListItem extends StatelessWidget {
  final Results result;
  final VoidCallback onClick;

  const MovieListItem({Key key, this.result, this.onClick}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: GestureDetector(
        onTap: ()=> onClick(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
              child: Image.network(
                '${AppKeys.ImageBaseUrl}${result.posterPath}',
                width: Get.width,
                height: 300,
                fit: BoxFit.cover,
                  errorBuilder: (_,f,errMessage){
                    return Center();
                  }
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    decoration: BoxDecoration(
                        border:
                        Border.all(color: AppColor.GrayDarker)),
                    child: Image.network(
                      '${AppKeys.ImageBaseUrl}${result.posterPath}',
                      fit: BoxFit.cover,
                      errorBuilder: (_,f,errMessage){
                        return Image.asset('assets/images/404.png',width: 64,height: 64,);
                      },
                    )),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 12,right: 8),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.Green,
                      borderRadius:
                      BorderRadius.all(Radius.circular(8))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      result.title,
                      style: TextThemes.whiteNormal20,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                    ),
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
                      shape: BoxShape.circle),
                  child: Text(
                    result.voteAverage.toString(),
                    style: TextThemes.blackNormal17,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
