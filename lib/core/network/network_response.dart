class NetworkResponse<T> {
  NetworkResponse(this.data, this.code, this.message);
  NetworkResponse.error(int code, String? message) : this(null, code, message);

  final dynamic data;
  final int code;
  final String? message;

  bool isSuccess() => code >= 200 && code <= 203;
}
