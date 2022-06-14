class ErrorResponse {
  ErrorResponse({
    required this.errors,
  });

  List<Error> errors;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        errors: List<Error>.from(json["errors"].map((x) => Error.fromJson(x))),
      );
}

class Error {
  Error({
    required this.code,
    required this.message,
  });

  String code;
  String message;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        code: json["code"],
        message: json["message"],
      );
}
