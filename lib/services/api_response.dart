class ApiResponse {
  var message = "";
  dynamic data;
  int success = 0;

  ApiResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    message = json['message'];
    success = json['success'];
  }

  String errorDisplay() {
    return "";
  }

  bool hasError() {
    return message.length > 0;
  }
}
