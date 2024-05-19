import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:go_routering/post_model.dart';

class PostApi {
  final Dio _dio = Dio();

  Future<List<PostModel>> getPost() async {
    print('object');

    final Response<String> response =
        await _dio.get('https://jsonplaceholder.typicode.com/posts');

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.data!) as List<dynamic>;
      return decodedResponse.map((e) => PostModel.fromJson(e)).toList();
    }
    return [];
  }
}
