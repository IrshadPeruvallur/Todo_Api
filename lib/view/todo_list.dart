import 'package:api_test/controller/todo_provider.dart';
import 'package:api_test/view/add_list.dart';
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
          // Fetch tasks from the provider
          todoProvider.getTasks();
          return todoProvider.noteList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  itemCount: todoProvider.noteList.length,
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final reversedIndex =
                        todoProvider.noteList.length - index - 1;
                    final task = todoProvider.noteList[reversedIndex];
                    return ListTile(
                      tileColor: const Color.fromARGB(255, 35, 35, 35),
                      title: Text(task.title.toString()),
                      subtitle: Text(task.description.toString()),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddList(),
          );
        },
        label: Text('Add Todo'),
      ),
    );
  }
}
