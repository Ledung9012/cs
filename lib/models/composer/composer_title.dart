import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/models/composer/composer_node.dart';

extension ComposerImage on ComposerNode {
  Widget titleEdit() {
    return Container(
      margin: EdgeInsets.only(top: 8, left: 16),
      child: Container(
        margin: EdgeInsets.only(right: 12),
        width: double.infinity,
        child: Focus(
          onFocusChange: (val) {
            if (!val) {
              if (headerEditController.text.length > 0) {
                value = headerEditController.text;
              }
            }
          },
          child: TextField(
            enableSuggestions: false,
            autocorrect: false,
            controller: headerEditController,
            onTap: () {},
            onSubmitted: (value) {},
            onEditingComplete: () {},
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
            decoration: InputDecoration(hintText: "Chủ đề bài viết "),
            minLines: 1,
            maxLines: 10,
          ),
        ),
      ),
    );
  }

  Widget titleView() {
    return Container(
      margin: EdgeInsets.only(left: 16, top: 16, bottom: 16),
      child: Text(
        (value == null) ? "" : value,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}
