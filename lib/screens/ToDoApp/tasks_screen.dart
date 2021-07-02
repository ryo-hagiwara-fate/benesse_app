import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatelessWidget { //Providerのlistenがあるのでstatelessウィジェットに変更
  static String id = "todo_screen";
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
                  GestureDetector(
                    onTap: (){ Navigator.pop(context); },
                    child: CircleAvatar(
                      child: Icon(Icons.list, size: 35, color: Colors.lightBlueAccent,),
                      radius: 30, backgroundColor: Colors.white,),
                  ),
                  SizedBox(height: 5,),
                  Text("nabedo", style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                  ),),
                  Text("${Provider.of<TaskData>(context).taskCount} tasks", style: TextStyle(
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
                // child: TasksList(tasks),
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
                  child: AddTaskScreen(), //Provider導入でcallback関数を渡す必要がなくなった
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

  @override
  Widget build(BuildContext context) {
    late String newTaskTitle;
    return Container( //丸角のContainerが返せなかったので、ダミーのContainerで本命を囲む
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
              // onChanged: onChanged
              onChanged: (newText){
                newTaskTitle = newText;
              },
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
                onPressed: (){
                  print("pressed!!");
                  print(newTaskTitle);
                  Provider.of<TaskData>(context, listen: false).addTask(newTaskTitle);
                  print("task was added!!");
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

//ListTileが集まったListViewのウィジェット
class TasksList extends StatelessWidget { //Providerでlistenできるのでstatelessでよい
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Consumer<TaskData>( // Providerが書き換えられると、ListView.builderがリビルドされる
        builder: (BuildContext context, taskData, child) {
          return ListView.builder(
            // itemCount: Provider.of<TaskData>(context).tasks.length, //Consumerウィジェット内なので、Provider.of<TaskData>(context)はtaskDataで書き換えられる
            itemCount: taskData.taskCount,
            itemBuilder: (BuildContext context, int index) {
              return TaskTile(
                taskTitle: taskData.tasks![index].name,
                isChecked: taskData.tasks![index].isDone,
                // taskTitle: widget.tasks[index].name, //widget.をつけることで、TaskListクラスの変数を使えるようになる！！
                //   isChecked: widget.tasks[index].isDone,
                checkboxCallback: (bool? checkboxState) { //②コールバック関数を引数に渡す
                  print("checked!");
                  taskData.updateTask(taskData.tasks![index]);
                },
                longPressCallback: (){
                  taskData.removeTask(taskData.tasks![index]);
                },
              );
            }
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
  final void Function() longPressCallback;
  TaskTile({required this.isChecked, required this.taskTitle, required this.checkboxCallback, required this.longPressCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(taskTitle, style: TextStyle(decoration: isChecked ? TextDecoration.lineThrough : null),),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: checkboxCallback,
        // onChanged: toggleCheckboxState, // ①チェックボックスが押されると、引数として渡されたコールバック関数を実行するので、setStateが使えるようになる
      ),
      onLongPress: longPressCallback,
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

//TaskData => ChangeNotifierを継承したクラス。Providerを使うため
class TaskData extends ChangeNotifier{
  //tasksをPrivateにするのは、外部からaddTaskを通さずにtaskリストを編集して、
  //notifyListeners()を忘れないようにするため
  List<Task> _tasks = [
    Task(name: "Buy milk"),
    Task(name: "Buy egg"),
    Task(name: "Buy bread"),
  ];

  UnmodifiableListView<Task>? get tasks { //ListViewとは何の関係もない
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(String newTaskTitle){
    final task = Task(name: newTaskTitle); //taskモデルで新しいインスタンス作成
    _tasks.add(task); //tasksリストに追加
    notifyListeners(); // これがないと、変更が反映されない！！（ChangeNotifierを継承したクラス内でのみ可能）
  }

  void updateTask(Task task){
    task.toggleDone();
    notifyListeners(); //絶対に忘れない。忘れるとリビルドしてくれない
  }

  void removeTask(Task task){
    // print(task.name);
    _tasks.remove(task);
    notifyListeners();
  }
}