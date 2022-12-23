import 'dart:convert';

class ErrorExceptions {
  String timestamp;
  int statusCode;
  String error;
  String message;
  String path;

  ErrorExceptions(
      {this.timestamp, this.statusCode, this.message, this.error, this.path});

  factory ErrorExceptions.fromJson(dynamic json) {
    return ErrorExceptions(
        timestamp: json["timestamp"] as String,
        statusCode: json["status"] as int,
        error: json["error"] as String,
        message: json["message"] as String,
        path: json["path"] as String);
  }

  static ErrorExceptions parseErrors(var responseBody) {
    Map<String, dynamic> parsed = jsonDecode(responseBody);
    return ErrorExceptions.fromJson(parsed);
  }

  @override
  String toString() {
    return "Errors: { timestamp: $timestamp, statusCode: $statusCode, error: $error, message: $message, path: $path }";
  }
}
