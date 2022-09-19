class ApiResponse {
  bool status = true;
  String? message;
  dynamic data;
  dynamic causes;

  ApiResponse({this.status = true, this.message, this.data, this.causes});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] ?? {};
    causes = json['causes'] ?? {};
  }

  Map<String, dynamic> toJson() {
    data['status'] = status;
    data['message'] = message;
    data['data'] = data;
    data['causes'] = causes;

    return data;
  }
}
