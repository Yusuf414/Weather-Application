import 'package:dio/dio.dart';

class ApiRepository {
  final String url;
  final Map<String, dynamic>? payload;
  ApiRepository({
    required this.url,
    this.payload,
  });
  Dio dio = Dio();
  void getData({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    dio.get(url, queryParameters: payload).then((response) {
      if (onSuccess != null) {
        onSuccess(response.data);
      }
    }).catchError((error) {
      if (onError != null) {
        onError(error);
      }
    });
  }
}
