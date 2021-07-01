import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: TasksList(),
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
                  child: AddTaskScreen(),
                )
            )
          );
        },
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.add),
      ),
    );
  }
  // Widget buildBottomSheet(BuildContext context){
  //   return Container(
  //     child: Center(
  //         child: Text("This is the bottomsheet")
  //     ),
  //   );
  // }
  // Widget buildBottomSheet(BuildContext context) => Container();
}

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({
    Key? key,
  }) : super(key: key);

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
            ),
            SizedBox(height: 10,),
            SizedBox(
              width: 400,
              height: 50,
              child: ElevatedButton(
                onPressed: () {print("clicked!!");},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
                ),
                child: Text("Add", style: TextStyle(
                    color: CupertinoColors.white,
                  fontSize: 19
                ),)
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
  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  List<Task> tasks = [
    Task(name: "Buy milk"),
    Task(name: "Buy egg"),
    Task(name: "Buy bread"),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: ListView(
        children: <Widget>[
          TaskTile(),
        ]
      ),
    );
  }
}

// ListTileのウィジェット
class TaskTile extends StatefulWidget {
  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isChecked = false; // statefulウィジェットなのでfinalを宣言しなくてよい

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Task 1", style: TextStyle(decoration: isChecked ? TextDecoration.lineThrough : null),),
      trailing: TaskCheckbox(
        checkboxState: isChecked,
        toggleCheckboxState: (bool? checkboxState) { //②コールバック関数を引数に渡す
          print("checked!");
          setState(() {
              isChecked = checkboxState!;
          });
        },
      ),
    );
  }
}

class TaskCheckbox extends StatelessWidget {
  final bool checkboxState; // statelessウィジェット内では、変数は基本的にfinal（変更されないため）
  final void Function(bool?) toggleCheckboxState;

  TaskCheckbox({required this.checkboxState, required this.toggleCheckboxState});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Colors.lightBlueAccent,
      value: checkboxState,
      onChanged: toggleCheckboxState, // ①チェックボックスが押されると、引数として渡されたコールバック関数を実行するので、setStateが使えるようになる
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