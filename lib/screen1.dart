import 'package:flutter/material.dart';
import 'package:project_1/Screen3.dart';
import 'package:project_1/Screen4.dart';
import 'package:project_1/services/Todo%20services.dart';

import 'Screen2.dart';

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        // Handle the picked date
        print("Selected date: ${picked.toLocal()}");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
              title: Text('TODO APP'),
              backgroundColor: Colors.purple[200],
              actions: [
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {
                    _selectDate(context);
                  },
                ),
              ],
            )
          : null,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          _buildTodoPage(),
          CompletedTaskPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Completed',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddTaskPage()))
              .then((value) => setState(() {}));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    );
  }

  Widget _buildTodoPage() {
    // Filter the tasks to show only the pending tasks
    List<Map> pendingTasks =
        Data.where((task) => task['isCompleted'] == false).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: pendingTasks.length,
      itemBuilder: (context, index) {
        int globalIndex = Data.indexWhere((task) =>
            task['title'] == pendingTasks[index]['title'] &&
            task['details'] == pendingTasks[index]['details']);

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(
              pendingTasks[index]['title'],
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
            ),
            subtitle: Text(pendingTasks[index]['details']),
            trailing: Wrap(
              spacing: 12, // space between two icons
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.purple),
                  onPressed: () async {
                    final updatedTask = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditTaskPage(
                                  index: globalIndex,
                                  title: pendingTasks[index]['title'],
                                  details: pendingTasks[index]['details'],
                                )));
                    if (updatedTask != null) {
                      setState(() {});
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.purple),
                  onPressed: () {
                    setState(() {
                      Data.removeAt(globalIndex);
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.check_circle, color: Colors.purple),
                  onPressed: () {
                    setState(() {
                      Data[globalIndex]['isCompleted'] = true;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CompletedTaskPage(),
                          ));
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
