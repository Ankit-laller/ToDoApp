import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Widget/ToDoItems.dart';
import '../models/todo.dart';
class HomePage extends StatefulWidget {

   HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todoList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> _foundresult =[];

  @override
  void initState() {
    _foundresult = todoList;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      appBar: AppBar(
          backgroundColor: CupertinoColors.extraLightBackgroundGray,
      elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu,
              color: Colors.black38,
              size: 30,

            ),
            InkWell(
              child: Container(
                height: 40,
                width: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Icon(Icons.supervised_user_circle,
                  color: Colors.black38,),

                ),
              ),
              onTap: changeTheme(ThemeMode.dark),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          "All To Dos",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      for(ToDo todoo in _foundresult)
                        ToDoItems(todo: todoo,
                        onChangeTodos: _handleToDos,
                        deleteItems: _deleteTodos,),

                    ],
                  ),
                )
              ],
            ),
    ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(child: Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                  left: 20,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const[
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(

                  controller: _todoController,
                  decoration: InputDecoration(
                    hintText: "Enter todo item",
                    border: InputBorder.none,
                  ),
                ),
              ),
              ),
              Container(
                margin: EdgeInsets.only(right: 20,bottom: 20),
                child:ElevatedButton(
                  child: Text("+",
                  style: TextStyle(fontSize: 40),),
                  onPressed: (){
                    _addToDo(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(60,60),
                    elevation: 10,
                  ),
                ) ,
              ),
            ],),
          )
        ],
      ),
    );
  }

   void _handleToDos(ToDo todo){
    setState(() {
      todo.isDone =!todo.isDone;
    });
  }
  void _deleteTodos(String id){
    setState(() {
      todoList.removeWhere((item) => item.id ==id);
    });
  }
   changeTheme(ThemeMode themeMode) {
    setState(() {
      ThemeMode _themeMode = ThemeMode.system;
      _themeMode = themeMode;
    });
  }
  void _addToDo(String todo){
    setState(() {
      if(todo.isNotEmpty){
        todoList.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: todo));
      }
    });
    _todoController.clear();
  }

  void _runfilter(String enterKeyWord){
    List<ToDo> result =[];
    if(enterKeyWord.isEmpty){
      result = todoList;
    }else{
      result = todoList.
      where((item) => item.todoText!.
      toLowerCase().
      contains(enterKeyWord.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundresult = result;
    });
  }
  Widget searchBox(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)
      ),
      child: TextField(
        onChanged: (value) => _runfilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              maxWidth: 25,
            ),
            border: InputBorder.none,
            hintText: "Search ...",
            hintStyle: TextStyle(color: CupertinoColors.extraLightBackgroundGray)
        ),
      ),
    );
  }

}




