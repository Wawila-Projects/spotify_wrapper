class HttpExeption implements Exception  {
  ///Message describing the error.
  final String message;
  
  ///Status code of the HTTP response.
  final int statusCode;

  const HttpExeption(this.statusCode, {this.message});

  String toString() => 'HTTP Exception: Status Code: $statusCode $message';
}