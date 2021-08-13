import 'package:film_fluent/core/constraints/app_constraints.dart';
import 'package:film_fluent/core/utils/app_colors.dart';
import 'package:film_fluent/core/utils/text_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomErrorWidget extends StatelessWidget {
  final VoidCallback onRefreshClicked;
  final double imageWidth,buttonWidth;
  final String errorMessage,imagePath;
  final bool showRefreshButton;

  const CustomErrorWidget({Key key, this.onRefreshClicked, this.imageWidth, this.errorMessage, this.buttonWidth, this.imagePath, this.showRefreshButton}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(imagePath,
            width: imageWidth, height: imageWidth, fit: BoxFit.cover,),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(errorMessage,style: TextThemes.blackNormal16),
          ),
          if(showRefreshButton)
          MaterialButton(
            onPressed: ()=>onRefreshClicked(),
            minWidth: buttonWidth,
            color: AppColor.BlueAccent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6))
            ),
            child: Text(AppConstraints.RefreshButton,style: TextThemes.whiteNormal15,),
          )
        ],
      ),
    );
  }
}
