import 'package:api_test/model/TodoModel.dart';
import 'package:dio/dio.dart';

class TodoService {
  Dio dio = Dio();
  final endpointUrl =
      'https://659fab885023b02bfe8a247e.mockapi.io/api/todo/Task';
  Future<List<TodoModel>> getTasks() async {
    try {
      Response response = await dio.get(endpointUrl);
      if (response.statusCode == 200) {
        var jsonList = response.data as List;
        List<TodoModel> tasks =
            jsonList.map((json) => TodoModel.fromJson(json)).toList();
        return tasks;
      } else {
        throw Exception("Failed to load tasks");
      }
    } catch (error) {
      throw error;
    }
  }

  createTask(TodoModel value) async {
    try {
      await dio.post(endpointUrl, data: value.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }
}
