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
              icon: Icons.delete,
              backgroundColor: const Color.fromARGB(255, 247, 16, 16),
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 135, 48, 181),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              //checkbox
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.black,
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