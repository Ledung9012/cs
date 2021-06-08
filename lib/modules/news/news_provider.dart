
import 'package:mobile/models/category.dart';
import 'package:mobile/models/news.dart';
import 'package:mobile/services/services.dart';

class NewsProvider {


  // Lấy danh mục tin tức
  void category({required Function(List<Category>) onSuccess,required Function(String) onError }) {
    Map body = Map();
    apiRequest.msRequest(APIFunction.NEWS_CATEGORY, body).then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        onSuccess(Category.list(response.data));
      }
    }).onError((error, stackTrace) {
      onError("")!;
    });
  }

  // lấy danh sách tin tức
  void index(int id,  Function(List<News>) onSuccess, Function(String) onError ) {
    Map body = Map();
    body['id'] = id;

    apiRequest.msRequest(APIFunction.NEWS_INDEX, body).then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());


        print("news list error ");


      } else {

        var newsList = News.list(response.data);

        print("news list : ${newsList.length}");

        onSuccess(News.list(response.data));
      }
    }).onError((error, stackTrace) {

      print("news list error $error");


      onError(error.toString());
    });
  }


  void create(int id, String title, dynamic content,String image, Function(News) onSuccess, Function(String) onError) {
    Map body = Map();
    body['title'] = title;
    body['content'] = content;
    body['image'] = image;
    body['user_id'] = id;

    apiRequest.msRequest(APIFunction.NEWS_CREATE, body).then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        onSuccess(News.list(response.data)[0]);
      }
    }).onError((error, stackTrace) {
      onError(error.toString());
    });
  }

  void details(int id, Function(News) onSuccess, Function(String) onError) {
    Map body = Map();
    body['id'] = id;

    apiRequest.msRequest(APIFunction.NEWS_DETAIL, body).then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        onSuccess(News.list(response.data)[0]);
      }
    }).onError((error, stackTrace) {
      onError(error.toString());
    });
  }

  void update(int id, Function(News) onSuccess, Function(String) onError) {
    Map body = Map();
    body['id'] = id;

    apiRequest.msRequest(APIFunction.NEWS_DETAIL, body).then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        onSuccess(News.list(response.data)[0]);
      }
    }).onError((error, stackTrace) {
      onError(error.toString());
    });
  }



  void delete(int id, Function(News) onSuccess, Function(String) onError) {
    Map body = Map();
    body['id'] = id;

    apiRequest.msRequest(APIFunction.NEWS_DELETE, body).then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        onSuccess(News.list(response.data)[0]);
      }
    }).onError((error, stackTrace) {
      onError(error.toString());
    });
  }


  void upload(String image, Function(News) onSuccess, Function(String) onError) {
    Map body = Map();
    body['media'] = image;

    apiRequest.msRequest(APIFunction.FILE_UPLOAD, body).then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {

      }
    }).onError((error, stackTrace) {
      onError(error.toString());
    });
  }
}
