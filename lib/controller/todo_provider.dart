// import 'package:api_test/model/TodoModel.dart';
// import 'package:api_test/services/todo_services.dart';
// import 'package:flutter/material.dart';

// class TodoProvider extends ChangeNotifier {
//   TextEditingController titlecontroller = TextEditingController();
//   TextEditingController descriptioncontroller = TextEditingController();
//   TodoService _todoService = TodoService();
//   List<TodoModel> noteList = [];
//   void getTasks() async {
//     try {
//       noteList = await _todoService.getTasks();
//     } catch (error) {
//       throw error;
//     }
//     notifyListeners();
//   }

//   createTask(context) async {
//     await _todoService.createTask(TodoModel(
//         title: titlecontroller.text, description: descriptioncontroller.text));
//     getTasks();
//     Navigator.pop(context);
//   }
// }
import 'package:api_test/model/TodoModel.dart';
import 'package:api_test/services/todo_services.dart';
import 'package:flutter/material.dart';

class TodoProvider extends ChangeNotifier {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TodoService _todoService = TodoService();
  List<TodoModel> noteList = [];

  void getTasks() async {
    try {
      noteList = await _todoService.getTasks();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  createTask() async {
    try {
      await _todoService.createTask(TodoModel(
          title: titlecontroller.text,
          description: descriptioncontroller.text));
      getTasks();
    } catch (error) {
      return null;
    }
  }
}
