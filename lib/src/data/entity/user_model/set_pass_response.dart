class SetPassApiResponse<T> {
  final bool isSuccess;
  final T? data;
  final String details;
  final int? statusCode;

  SetPassApiResponse({
    required this.isSuccess,
    this.data,
    required this.details,
    this.statusCode,
  });
}
