import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;

  const TodoList({
    super.key,
    required this.taskName, 
    required this.taskCompleted,
    required this.onChanged
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             SizedBox(height: 10),
             Checkbox(value: taskCompleted, onChanged: onChanged),
             SizedBox(height: 5),
             Text(taskName),
            ],
          ),
        ),
      ),
    );
  }
}