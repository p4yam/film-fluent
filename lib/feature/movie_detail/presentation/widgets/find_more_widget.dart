import 'package:film_fluent/core/constraints/app_constraints.dart';
import 'package:film_fluent/core/utils/app_colors.dart';
import 'package:film_fluent/core/utils/text_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindMoreWidget extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onClick;

  const FindMoreWidget({Key key, this.isLoading, this.onClick}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>onClick(),
      child: Container(
        height: 48,
        width: Get.width,
        decoration: BoxDecoration(
            color: AppColor.GrayLight
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppConstraints.FindMoreButton,style: TextThemes.blackNormal17,),
              isLoading? CircularProgressIndicator():Icon(Icons.keyboard_arrow_down)
            ],
          ),
        ),
      ),
    );

  }
}
