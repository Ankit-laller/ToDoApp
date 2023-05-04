class ToDo{
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
   required this.id,
   required this.todoText,
    this.isDone = false
});
  static List<ToDo> todoList(){
    return [
      ToDo(id: "1", todoText: "complete the project", isDone: true),
      ToDo(id: "2", todoText: "check nothing"),
      ToDo(id: "3", todoText: "play cricket", isDone: true),
      ToDo(id: "4", todoText: "Take a nap"),
      ToDo(id: "5", todoText: "Take a again nap")
    ];
  }
}