import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService extends GetxService {
  Future<ApiResponse> get(String methodName, args, ) async {
    final url = "${dotenv.env['API_URL']}/api/method/$methodName";
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
