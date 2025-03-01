// Base exception class
class AppException implements Exception {
  final String? message;
  final String? prefix;

  AppException([this.message, this.prefix]);

  @override
  String toString() {
    return "${prefix ?? 'Exception'}: ${message ?? 'Something went wrong'}";
  }
}

// Specific exception types
class ServerException extends AppException {
  ServerException([String? message]) : super(message, 'Server Error');
}

class EmptyStateException extends AppException {
  EmptyStateException([String? message])
      : super(message, 'Instance of something equal null');
}

class NetworkException extends AppException {
  NetworkException([String? message]) : super(message, 'Network Error');
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String? message]) : super(message, 'Unauthorized');
}
