import 'package:flutter/material.dart';
import 'package:project_1/customtxtfeild.dart';
import 'package:project_1/services/Todo%20services.dart';

class EditTaskPage extends StatefulWidget {
  final int index;
  final String? title;
  final String? details;

  EditTaskPage({required this.index, this.title, this.details});

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    titleController.text = widget.title ?? "";
    detailController.text = widget.details ?? "";
    super.initState();
  }

  void updateTask({required String title, required String details}) {
    setState(() {
      Data[widget.index]['title'] = title;
      Data[widget.index]['details'] = details;
    });
    Navigator.pop(context, true); // Indicate success
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
        backgroundColor: Colors.purple[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  customtxtformfeild(
                      Controller: titleController,
                      labeltext: "Title",
                      warning: "Please enter the title"),
                  SizedBox(height: 16.0),
                  customtxtformfeild(
                      Controller: detailController,
                      labeltext: "Details",
                      warning: "Please enter the details"),
                  SizedBox(height: 32.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState?.validate() ?? false) {
                            updateTask(
                                title: titleController.text,
                                details: detailController.text);
                          }
                        },
                        child: Text('Update'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple[200],
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple[200],
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
