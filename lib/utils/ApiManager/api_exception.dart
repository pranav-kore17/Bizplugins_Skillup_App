class ApiException implements Exception {
  final message;
  final prefix;
  ApiException([this.message, this.prefix]);
}

class FetchDataException extends ApiException {
  FetchDataException({String? message})
    : super(message, "Something went wrong! Please try again");
}

class UnAuthorizedException extends ApiException {
  UnAuthorizedException({String? message})
    : super(message, "UnAuthorized Exception");
}
