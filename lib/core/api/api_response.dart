class ApiResponse<T> {
  final T body;
  final bool error;
  final String errorMsg;

  ApiResponse({
    required this.body,
    required this.error,
    required this.errorMsg,
  });
}
