class HttpException implements Exception {}


class HttpRequestFailure implements Exception {
  const HttpRequestFailure(
    this.statusCode,
    this.error,
    this.body,
  );

  /// The status code of the response.
  final int statusCode;

  /// The error message of the response.
  final String error;

  /// The body of the response.
  final String body;

  @override
  String toString() =>
      'HttpRequestFailure(statusCode: $statusCode, error: $error)';
}


/// Thrown when an error occurs while decoding the response body.
class JsonDecodeException implements Exception {
  /// Thrown when an error occurs while decoding the response body.
  const JsonDecodeException();
}

/// Thrown when an error occurs while decoding the response body.
class SpecifiedTypeNotMatchedException implements Exception {
  /// Thrown when an error occurs while decoding the response body.
  const SpecifiedTypeNotMatchedException();
}

/// Thrown when an unknown error occurs.
class UnknownException implements Exception {
  /// Thrown when an unknown error occurs.
  const UnknownException();
}