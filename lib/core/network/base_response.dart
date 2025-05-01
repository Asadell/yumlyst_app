class BaseResponse<T> {
  final int statusCode;
  final String? message;
  final T? data;

  BaseResponse({
    required this.statusCode,
    this.message,
    this.data,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return BaseResponse(
      statusCode: json['status_code'] as int,
      message: json['message'] as String?,
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return {
      'status_code': statusCode,
      'message': message,
      'data': data != null ? toJsonT(data as T) : null,
    };
  }
}
