import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mylist/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

   DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    });

  @override
  Widget build(BuildContext context) {
      return AlertDialog(
        backgroundColor: Color.fromARGB(255, 135, 48, 181),
        shape: RoundedRectangleBorder(
        
          borderRadius: BorderRadius.circular(12)
        ),
        content: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 110,
        
            child: Column(
            
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  controller: controller,
      
                  autofocus: true,
                  decoration: InputDecoration(
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                    ),
                
                  hintText: "Add a new task",
    
                  ),
                ),
              Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
               
                MyButton(text: "Save", onPressed: onSave,
                ),
          
                const SizedBox(width: 8),
          
                MyButton(text: "Cancel", onPressed: onCancel),
              ],)
          
              ],
            ),
          ),
        ),
      );
  }
}