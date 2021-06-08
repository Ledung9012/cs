import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/models/composer/composer_node.dart';

extension ComposerHeader on ComposerNode{


  Widget headerEditing() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 16),
            width: 48,
            child: Icon(
              Icons.menu_rounded,
              color: Template.subColor.withOpacity(0.5),
              size: 20,
            ),
          ),
          Expanded(
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
                  onTap: () {
                  },
                  onSubmitted: (value) {
                  },
                  onEditingComplete: () {},
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                  decoration:  editingStyle,
                  minLines: 1,
                  maxLines: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }




  Widget headerView() {
    return Container(
      margin: EdgeInsets.only(top: 16, left: 16, right: 16, bottom:  8),
      child: Text(
        (value == null) ? "" : value,
        style: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }

}