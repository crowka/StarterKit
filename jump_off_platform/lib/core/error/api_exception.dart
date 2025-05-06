class AppException implements Exception {
  final dynamic _message; // Changed to dynamic to match common practices, consider String?
  final dynamic _prefix;  // Changed to dynamic, consider String?

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) // Made message nullable
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([dynamic message]) : super(message, "Invalid Request: "); // Kept message dynamic as original
}

class UnauthorisedException extends AppException {
  UnauthorisedException([dynamic message]) : super(message, "Unauthorised: "); // Kept message dynamic as original
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: "); // Made message nullable
} 