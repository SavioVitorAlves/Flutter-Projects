class HttpExceptions implements Exception{
  final String msg;
  final int statusCode;

  HttpExceptions({
    required this.msg,
    required this.statusCode,
  });

  @override
  String toString() {
    // TODO: implement toString
    return msg;
  }
}