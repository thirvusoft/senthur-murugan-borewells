import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService extends GetxService {
  Future<ApiResponse> get(String methodName, args) async {
    final url = "https://oxo.thirvusoft.co.in/api/method/$methodName";
     final uri = Uri.parse(url).replace(queryParameters: args);

    final response = await http.get(uri);

    return ApiResponse(
      statusCode: response.statusCode,
      body: response.body,
    );
  }
}

class ApiResponse {
  final int statusCode;
  final String body;

  ApiResponse({
    required this.statusCode,
    required this.body,
  });
}
