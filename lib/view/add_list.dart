import 'package:api_test/controller/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTask extends StatelessWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final getProvider = Provider.of<TodoProvider>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: getProvider.titlecontroller,
                decoration: InputDecoration(hintText: "Title"),
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(hintText: "Description"),
                controller: getProvider.descriptioncontroller,
                minLines: 5,
                maxLines: 8,
              ),
              SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await getProvider.createTask();
                    if (await getProvider.isCreated == false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Failed to create task. Please try again.'),
                        ),
                      );
                    } else if (await getProvider.isCreated == true) {
                      getProvider.titlecontroller.clear();
                      getProvider.descriptioncontroller.clear();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Created a new Task')),
                      );
                    }
                  },
                  child: Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
