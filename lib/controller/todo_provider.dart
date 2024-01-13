import 'dart:developer';

import 'package:api_test/model/TodoModel.dart';
import 'package:api_test/services/todo_services.dart';
import 'package:flutter/material.dart';

class TodoProvider extends ChangeNotifier {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TodoService _todoService = TodoService();
  List<TodoModel> taskList = [];
  late bool isCreated;
  late bool isDeleted;
  late bool isEdited;

  Future<void> getTasks() async {
    try {
      await Future.delayed(Duration(seconds: 2));

      taskList = await _todoService.getTasks();
      notifyListeners();
    } catch (error) {
      log('Error fetching tasks: $error');
      rethrow;
    }
  }

  Future<void> createTask() async {
    try {
      await _todoService.createTask(TodoModel(
        title: titlecontroller.text,
        description: descriptioncontroller.text,
      ));
      isCreated = true;
      notifyListeners();
    } catch (error) {
      isCreated = false;
      log('Error creating task: $error');
      throw error;
    }
  }

  deleteTask(String id) async {
    try {
      await _todoService.deleteTask(id);
      isDeleted = true;
      notifyListeners();
      // getTasks();
    } catch (error) {
      isDeleted = false;
      log('Error deleting task: $error');
      throw error;
    }
  }

  editTask(String id) async {
    try {
      await _todoService.editTask(
          TodoModel(
              title: titlecontroller.text,
              description: descriptioncontroller.text),
          id);
      isEdited = true;
    } catch (e) {
      isEdited = false;
      throw e;
    }
  }
}
