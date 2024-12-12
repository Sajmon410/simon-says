import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

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
//reference the hive
final _myBox=Hive.box('mybox');
ToDoDataBase db = ToDoDataBase();
  final _controller = TextEditingController();
 
 @override
  void initState() {
    //  implement initState
    if(_myBox.get("TODOLIST")==null){
      db.createInitialData();
    }else{
      db.loadData();
    }
    super.initState();
  }


void checkBoxChanged(bool? value, int index){
  setState(() {
    db.toDoList[index][1]=!db.toDoList[index][1];
  });
  db.updateDataBase();
}

//save new task
void saveNewTask(){
  setState(() {
    db.toDoList.add([ _controller.text, false]);
     _controller.clear();
  });
      Navigator.of(context).pop();
       db.updateDataBase();
}

void updateTask(int index, String newTask){
  setState(() {
    db.toDoList[index][0] = newTask;
    db.updateDataBase();
  });
}

void createNewTask(){
  showDialog(context: context,
   builder: (context){
      return DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: () => Navigator.of(context).pop(),
      );
   });
}
void editTask(index){
  _controller.text = db.toDoList[index][0];
  showDialog(context: context,
   builder: (context){
    return DialogBox(
      controller: _controller,
     onSave: () { 
      updateTask(index,_controller.text);
     _controller.clear();
    Navigator.of(context).pop();
     },
      onCancel: (){Navigator.of(context).pop();
      _controller.clear();}
      );
   });

}
void deleteTask(int index){
  setState(() {
    db.toDoList.removeAt(index);
  });
    db.updateDataBase();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text("TO DO"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.yellow,
        child: Icon(Icons.add)
        ),
      body: ListView.builder(
       itemCount: db.toDoList.length,
       itemBuilder:(context, index) {
        return ToDoTile(
          taskName: db.toDoList[index][0], 
          taskCompleted: db.toDoList[index][1], 
          onChanged: (value) =>checkBoxChanged(value,index),
          deleteFunction: (context) => deleteTask(index),
          editFunction: (context) => editTask(index),
          );
       },
      ),
    );
  }
}