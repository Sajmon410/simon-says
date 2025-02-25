import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mylist/data/database.dart';
import 'package:mylist/util/dialog_box.dart';
import 'package:mylist/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();
  final _controller = TextEditingController();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      if(_controller.text.trim().isEmpty){return;}
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void updateTask(int index, String newTask) {
    setState(() {
      db.toDoList[index][0] = newTask;
      db.updateDataBase();
    });
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void editTask(int index) {
    _controller.text = db.toDoList[index][0];
    WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: () {
            if(_controller.text.trim().isNotEmpty)
            {
            updateTask(index, _controller.text);
            Navigator.of(context).pop();
            Future.delayed(const Duration(milliseconds: 300),(){
              _controller.clear();
            });
            }
          },
          onCancel: () {
            Navigator.of(context).pop();
              Future.delayed(const Duration(milliseconds: 300), () {
               _controller.clear(); // Očisti kontroller nakon što se dijalog zatvori
            });
            
          },
        );
      },
    );
  });
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFF10001B),
      appBar: AppBar(
        backgroundColor:Color.fromARGB(129, 158, 1, 255),
        title: const Text("Simon Says",
        style: TextStyle( color: Colors.white
        )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Color.fromARGB(142, 158, 1, 255),
        child: const Icon(Icons.add, color: Colors.white,),
      ),
      body: db.toDoList.isEmpty
      ? const Center(
        child: Text(
          "No tasks yet.\nTap + to add a new one!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      )
      
      
      
      
     : ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
            editFunction: (context, index) => editTask(index),  // Prosleđivanje index-a
            index: index,  // Prosleđivanje index-a u ToDoTile
          );
        },
      ),
    );
  }
}