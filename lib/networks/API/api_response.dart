import 'dart:convert';

class ApiResponse<T> {
  Status? status;

  T? data;

  String? message;

  ApiResponse.loading(this.message) : status = Status.LOADING;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "success : $status \n message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }

class Error {
  Error({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory Error.fromRawJson(String str) => Error.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        success: json["status_code"],
        message: json["status_message"],
        data: Data.fromJson(json["success"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.error,
  });

  String error;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
      };
}
