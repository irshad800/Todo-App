import 'package:flutter/material.dart';
import 'package:project_1/services/Todo%20services.dart';

// Assuming Data contains a key 'isCompleted' to check if the task is completed

class CompletedTaskPage extends StatefulWidget {
  @override
  State<CompletedTaskPage> createState() => _CompletedTaskPageState();
}

class _CompletedTaskPageState extends State<CompletedTaskPage> {
  @override
  Widget build(BuildContext context) {
    // Filter completed tasks
    List<Map> completedTasks =
        Data.where((task) => task['isCompleted'] == true).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Tasks'),
        backgroundColor: Colors.purple[200],
      ),
      body: Container(
        color: Colors.purple[50],
        child: completedTasks.isEmpty
            ? Center(child: Text('No completed tasks'))
            : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: completedTasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ListTile(
                      title: Text(
                        completedTasks[index]['title'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.purple),
                      ),
                      subtitle: Text(completedTasks[index]['details']),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
