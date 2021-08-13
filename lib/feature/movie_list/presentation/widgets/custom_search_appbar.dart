import 'package:film_fluent/core/constraints/app_constraints.dart';
import 'package:film_fluent/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSearchAppbar extends StatefulWidget implements PreferredSizeWidget {
  final Function(String) onSearchClicked;
  final VoidCallback onClearTextClicked;

  const CustomSearchAppbar({Key key, this.onSearchClicked, this.onClearTextClicked}) : super(key: key);
  @override
  _CustomSearchAppbarState createState() => _CustomSearchAppbarState();

  @override
  Size get preferredSize => Size(Get.width,56);
}

class _CustomSearchAppbarState extends State<CustomSearchAppbar> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _textController,
              textInputAction: TextInputAction.search,
              onFieldSubmitted: (value){
                FocusScope.of(context).unfocus();
                widget.onSearchClicked(value);
              },
              decoration:
              InputDecoration(hintText: AppConstraints.SearchHint),
            ),
          ),
          IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              _textController.text='';
              widget.onClearTextClicked();
            },
            icon: Icon(Icons.close,color: AppColor.Gray,),
          ),
          IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              widget.onSearchClicked(_textController.text);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
    );
  }
}

