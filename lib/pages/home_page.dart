import 'package:flutter/material.dart';
import 'package:mylist/util/dialog_box.dart';
import 'package:mylist/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _controller = TextEditingController();
  //list to do tasks
  List toDoList=[
    ["Make A Tutorial",false],
    ["Do Excersise",false],
  ];

void checkBoxChanged(bool? value, int index){
  setState(() {
    toDoList[index][1]=!toDoList[index][1];
  });
}

//save new task
void saveNewTask(){
  setState(() {
    toDoList.add([ _controller.text, false]);
     _controller.clear();
  });
      Navigator.of(context).pop();
     
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
void deleteTask(int index){
  setState(() {
    toDoList.removeAt(index);
  });
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
       itemCount: toDoList.length,
       itemBuilder:(context, index) {
        return ToDoTile(
          taskName: toDoList[index][0], 
          taskCompleted: toDoList[index][1], 
          onChanged: (value) =>checkBoxChanged(value,index),
          deleteFunction: (context) => deleteTask(index),
          );
       },
      ),
    );
  }
}