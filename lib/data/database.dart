import 'package:hive/hive.dart';

class ToDoDataBase{

  List toDoList=[];
  //rederence our box
  final _myBox= Hive.box('mybox');

  //initial
  void createInitialData(){
    toDoList=[

    ];
  }
//load the data
void loadData(){
  toDoList  = _myBox.get("TODOLIST");
}
//update the database
void updateDataBase(){
  _myBox.put("TODOLIST",toDoList);
}
}