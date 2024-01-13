// ...

import 'package:api_test/controller/todo_provider.dart';
import 'package:api_test/view/add_list.dart';
import 'package:api_test/view/edit_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          todoProvider.getTasks();
          return todoProvider.taskList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  itemCount: todoProvider.taskList.length,
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final reversedIndex =
                        todoProvider.taskList.length - index - 1;
                    final task = todoProvider.taskList[reversedIndex];
                    return ListTile(
                      tileColor: const Color.fromARGB(255, 35, 35, 35),
                      title: Text(task.title.toString()),
                      subtitle: Text(task.description.toString()),
                      trailing: PopupMenuButton<String>(
                        onSelected: (String result) async {
                          if (result == 'Delete') {
                            await todoProvider.deleteTask(task.id.toString());
                            if (await todoProvider.isDeleted == false) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Failed to delete task. Please try again.'),
                                ),
                              );
                            } else if (await todoProvider.isDeleted == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Delete Successfully ')),
                              );
                            }
                          } else if (result == "Edit") {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => EditTask(
                                title: task.title,
                                description: task.description,
                                id: task.id,
                              ),
                            );
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'Edit',
                            child: Text('Edit'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'Delete',
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddTask(),
          );
        },
        label: Text('Add Todo'),
      ),
    );
  }
}
