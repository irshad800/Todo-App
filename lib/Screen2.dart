import 'package:flutter/material.dart';
import 'package:project_1/customtxtfeild.dart';
import 'package:project_1/screen1.dart';
import 'package:project_1/services/Todo%20services.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  List<Map<String, dynamic>> Data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
        backgroundColor: Colors.purple[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              customtxtformfeild(
                  Controller: titleController,
                  labeltext: "title",
                  warning: "please enter the title"),
              SizedBox(height: 16.0),
              customtxtformfeild(
                  Controller: detailController,
                  labeltext: "details",
                  warning: "Please enter the title"),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState?.validate() ?? false) {
                    AddTask(
                        title: titleController.text,
                        details: detailController.text);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TodoHomePage(),
                        ));
                  }
                },
                child: Text('ADD'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[200],
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: Data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(Data[index]['title']),
                      subtitle: Text(Data[index]['details']),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
