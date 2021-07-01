import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {

  List<Task> tasks = [
    Task(name: "Buy milk"),
    Task(name: "Buy egg"),
    Task(name: "Buy bread"),
  ];

  @override
  Widget build(BuildContext context) {
    late String newTaskTitle="";
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    child: Icon(Icons.list, size: 35, color: Colors.lightBlueAccent,),
                    radius: 30, backgroundColor: Colors.white,),
                  SizedBox(height: 5,),
                  Text("nabedo", style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                  ),),
                  Text("12 tasks", style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [BoxShadow(
                    color: Colors.black38.withOpacity(0.5),
                    blurRadius: 7,
                  )],
                ),
                child: TasksList(tasks),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // これをtrueにすると、キーボードが出たときに自動でBottomSheetが上に上がる
            // builder: (context) => AddTaskScreen()
            builder: (context) => SingleChildScrollView(
                child:Container(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: AddTaskScreen(
                    onChanged: (newText){ //このnewTextは、valueでもいい（TextFieldに入力された文字が取り出されている）
                      newTaskTitle = newText;
                    },
                    onTap: (){
                      setState(() {
                        tasks.add(Task(name: newTaskTitle));
                        Navigator.pop(context);
                      });
                    },
                  ),
                )
            )
          );
        },
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddTaskScreen extends StatelessWidget {
  // final Function addTaskCallback;
  // AddTaskScreen(this.addTaskCallback);
  final onChanged;
  final onTap;

  AddTaskScreen({this.onChanged, this.onTap});

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("Add Task", textAlign: TextAlign.center, style: TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 30
            ),),
            TextField(
              autofocus: true,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
              onChanged: onChanged
            ),
            SizedBox(height: 10,),
            SizedBox(
              width: 400,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
                ),
                child: Text("Add", style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 19
                ),),
                // onPressed: (){
                //   print(newTaskTitle);
                // }
                onPressed: onTap,
                // onPressed: addTaskCallback(newTaskTitle),
              ),
            )
          ],
        ),
      ),
    );
  }
}


//ListTileが集まったListViewのウィジェット
class TasksList extends StatefulWidget {

  final List<Task> tasks;
  TasksList(this.tasks);

  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: ListView.builder(
        itemCount: widget.tasks.length, itemBuilder: (BuildContext context, int index) {
          return TaskTile(
              taskTitle: widget.tasks[index].name, //widget.をつけることで、TaskListクラスの変数を使えるようになる！！
              isChecked: widget.tasks[index].isDone,
              checkboxCallback: (bool? checkboxState) { //②コールバック関数を引数に渡す
                print("checked!");
                setState(() {
                  widget.tasks[index].toggleDone();
                });
              },
          );
        },
      ),
    );
  }
}

// ListTileのウィジェット
class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final void Function(bool?) checkboxCallback;
  TaskTile({required this.isChecked, required this.taskTitle, required this.checkboxCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(taskTitle, style: TextStyle(decoration: isChecked ? TextDecoration.lineThrough : null),),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: checkboxCallback,
        // onChanged: toggleCheckboxState, // ①チェックボックスが押されると、引数として渡されたコールバック関数を実行するので、setStateが使えるようになる
      )
    );
  }
}









//Taskモデル
class Task{
  final String name;
  bool isDone;

  Task({required this.name, this.isDone = false});

  void toggleDone(){
    isDone = !isDone;
  }
}