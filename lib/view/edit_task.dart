import 'package:api_test/controller/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTask extends StatefulWidget {
  final String? title;
  final String? description;
  final String? id;
  const EditTask({Key? key, this.title, this.description, this.id})
      : super(key: key);
  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  @override
  void initState() {
    final getProvider = Provider.of<TodoProvider>(context, listen: false);
    getProvider.titlecontroller.text = widget.title!;
    getProvider.descriptioncontroller.text = widget.description!;
    super.initState();
  }

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
                    await getProvider.editTask(widget.id!);
                    if (await getProvider.isEdited == false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Failed to edit task. Please try again.'),
                        ),
                      );
                    } else if (await getProvider.isEdited == true) {
                      getProvider.titlecontroller.clear();
                      getProvider.descriptioncontroller.clear();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Update Successfully ')),
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
