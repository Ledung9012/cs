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

extension ComposerImageGroup on ComposerNode {
  Widget imagesView() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          child: value[0],
          decoration: BoxDecoration(),
        ),
      ),
    );
  }

  Widget imagesEditing() {
    if (value == null) {
      value = List.empty();
    }

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
              margin: EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              width: double.infinity,
              child: GridView.builder(
                physics: new NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: value.length + 1,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1,
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12),
                itemBuilder: (BuildContext context, int index) {
                  return buildCell(index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCell(int index) {
    if (value.length == index) {
      return GestureDetector(
        onTap: () {
          getImage();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(4)),
            child: Icon(
              Icons.add_a_photo_outlined,
              color: Colors.redAccent.withOpacity(0.5),
            ),
          ),
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Container(
        child: FittedBox(
          child: CachedNetworkImage(
            imageUrl: value[index].path,
          ),
          fit: BoxFit.cover,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
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
          .post("http://apicashback.lolshop.vn/upload", data: formData)
          .then((dynamic result) {
        ApiResponse apiResponse =
            ApiResponse.fromJson(jsonDecode(result.toString()));
        var dtos = FileUpload.list(apiResponse.data);
        if (value == null) {
          value = List.empty();
        }
        if (dtos.length > 0) {
          (value as List).add(dtos[0]);
        }
      }).onError((error, stackTrace) {
        print("response error : ${error}");
      });
    } else {
      print('No image selected.');
    }
  }
}
