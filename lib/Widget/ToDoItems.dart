import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/models/todo.dart';
class ToDoItems extends StatelessWidget {
  final ToDo todo;
  final onChangeTodos;
  final deleteItems;
  const ToDoItems({Key? key, required this.todo, required this.onChangeTodos, required this.deleteItems}) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: (){
          onChangeTodos(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        leading: Icon(
          todo.isDone ? Icons.check_box: Icons.check_box_outline_blank,color: Colors.blue,),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            decoration: todo.isDone ? TextDecoration.lineThrough:null
          ),
        ),
        trailing: Container(
          height: 35,
          width: 35,
          child: IconButton(
            color: Colors.red,
            icon: Icon(Icons.delete),
            onPressed: () {
              deleteItems(todo.id);
            },

          ),

        ),
        
      ),
    );
  }
}
