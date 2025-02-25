import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mylist/util/edit_button.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  Function(BuildContext, int)? editFunction;  // Funkcija koja prima BuildContext i index

  final int index;  // Dodajemo index kao parametar

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    required this.editFunction,
    required this.index, // Prosleđivanje index-a
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
           SlidableAction(
          onPressed: deleteFunction,
          backgroundColor: const Color.fromARGB(255, 190, 3, 3), // Red background
          borderRadius: BorderRadius.circular(12),
          foregroundColor: Colors.white, // Ensures icon color is white
          icon: Icons.delete,
        ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Color.fromARGB(142, 158, 1, 255),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              //checkbox
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.black,
                side: BorderSide(color: Colors.white, width: 2),
              ),
              //task name
                
           ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 199, 
              ),
              child: Text(
                taskName,
                maxLines: 1,
               overflow: TextOverflow.ellipsis, 
                style: TextStyle(
                  color: Colors.white,
                  decoration: taskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
           
           
              const Spacer(),
             EditButton(
              onPressed: (){if(editFunction!=null){
                editFunction!(context,index);
              }
              
              }
             )
            ],
          ),
        ),
      ),
    );
  }
}