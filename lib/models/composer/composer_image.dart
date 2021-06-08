import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/models/composer/composer_node.dart';
import 'package:mobile/models/file_upload.dart';
import 'package:mobile/services/api_response.dart';

extension ComposerImage on ComposerNode {
  Widget imageEdit() {
    return Container(
      margin: EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 16, bottom: 12),
            child: Text(
              "Ảnh chính của bài viết",
              style: TextStyle(color: Template.primaryColor),
            ),
          ),
          GestureDetector(
            onTap: () {
              getImage();
            },
            child: Container(
              margin: EdgeInsets.only(left: 16, bottom: 12),
              width: 86,
              height: 86,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: getImageSelect(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getImageSelect() {
    if (!isEmpty()) {
      return Container(
        child: FittedBox(
          child: CachedNetworkImage(
            imageUrl: (value[0] as FileUpload).path,
          ),
          fit: BoxFit.cover,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(4),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(4)),
        child: Icon(
          Icons.add_a_photo_outlined,
          color: Colors.redAccent.withOpacity(0.5),
        ),
      );
    }
  }

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      String fileName = pickedFile.path.split('/').last;
      MultipartFile fileUpload =
          await MultipartFile.fromFile(pickedFile.path, filename: fileName);
      FormData formData = FormData.fromMap({'media': fileUpload});
      return await Dio()
          .post("http://apiaccesstrade.lolshop.vn/upload", data: formData)
          .then((dynamic result) {
        ApiResponse apiResponse =
            ApiResponse.fromJson(jsonDecode(result.toString()));
        var dtos = FileUpload.list(apiResponse.data);

        print(apiResponse.data);

        if (dtos.length > 0) {
          value = dtos;
        }
      }).onError((error, stackTrace) {
        print("upload image false $error");
      });
    } else {}
  }

  Widget imageView() {
    print("---------------------value : $value");
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          child: (!isEmpty())
              ? CachedNetworkImage(imageUrl: value[0].path)
              : Container(),
          decoration: BoxDecoration(),
        ),
      ),
    );
  }
}
