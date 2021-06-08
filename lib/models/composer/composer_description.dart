import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/models/composer/composer_node.dart';





extension ComposerDescription on ComposerNode {




  Widget descriptionView() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 0),
      child: RichText(
        softWrap: true,
        textAlign: TextAlign.left,
        text: TextSpan(
          text: value,
          style: TextStyle(
            color: Colors.black.withOpacity(0.7),
            fontSize: 17,
          ),
        ),
      ),
    );
  }



  Widget desciptionEditting() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            child: Icon(
              Icons.menu_rounded,
              color: Template.subColor.withOpacity(0.5),
              size: 20,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 12),
              margin: EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                      color: Template.subColor.withOpacity(0.1))),
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
                  onTap: () {
                  },
                  onSubmitted: (value) {
                  },
                  onEditingComplete: () {},
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  decoration: completeStyle,
                  minLines: 3,
                  maxLines: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }





}
