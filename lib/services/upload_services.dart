

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/models/file_upload.dart';
import 'package:mobile/services/api_response.dart';

class UploadServices {
  static void upload({required PickedFile pickedFile ,required Function(FileUpload) onSuccess}) async{
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
      print(apiResponse.data);
      if (dtos.length > 0) {
        onSuccess(dtos[0]);
      }
    }).onError((error, stackTrace) {});
  }

}