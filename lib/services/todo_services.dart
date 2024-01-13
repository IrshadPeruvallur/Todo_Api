import 'dart:developer';

import 'package:api_test/model/TodoModel.dart';
import 'package:dio/dio.dart';

class TodoService {
  final Dio _dio = Dio();
  final String _endpointUrl =
      'https://659fab885023b02bfe8a247e.mockapi.io/api/todo/Task';

  Future<List<TodoModel>> getTasks() async {
    try {
      final Response response = await _dio.get(_endpointUrl);
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => TodoModel.fromJson(json))
            .toList();
      } else {
        throw Exception("Failed to load tasks");
      }
    } catch (error) {
      log('$error');
      throw error;
    }
  }

  Future<void> createTask(TodoModel task) async {
    try {
      await _dio.post(_endpointUrl, data: task.toJson());
    } catch (error) {
      log('Error creating task: $error');
      throw Exception(error);
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await _dio.delete('$_endpointUrl/$id');
    } catch (error) {
      log('Error deleting task: $error');
      throw Exception(error);
    }
  }

  Future<void> editTask(TodoModel value, String id) async {
    try {
      await _dio.put('$_endpointUrl/$id', data: value.toJson());
    } catch (error) {
      log('Error editTask task: $error');
      throw Exception(error);
    }
  }
}
