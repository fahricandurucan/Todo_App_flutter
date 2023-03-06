import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todo_app_flutter/data/LocalStorage.dart';
import 'package:todo_app_flutter/main.dart';
import 'package:todo_app_flutter/models/Task.dart';
import 'package:todo_app_flutter/widgets/TaskListItem.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<Task> allTasks;
  late LocalStorage localStorage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localStorage = locator<LocalStorage>();
    allTasks = <Task>[];
    getAllTaskFromDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: GestureDetector(
          onTap: (){
            addTask(context);
          },
          child: Text("Bugün neler yapacaksın?",style: TextStyle(color: Colors.black),),
        ),

        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.search),
          ),
          IconButton(
              onPressed: (){
                addTask(context);
              },
              icon: Icon(Icons.add),
          ),
        ],
      ),
      body: allTasks.isNotEmpty ? ListView.builder(
          itemCount: allTasks.length,
          itemBuilder: (context,index){
            var task = allTasks[index];
            return Dismissible(
                background: Container(
                  color: Colors.redAccent,
                  alignment: Alignment.center,
                  child: Text("Silindi",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
                ),
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                onDismissed: (x){
                  setState(() async{
                    allTasks.removeAt(index);
                    await localStorage.deleteTask(task: task);
                  });
                },
                child: TaskListItem(task: task,),
            );
          }
      ) :
         Center(
           child: Text("Görev Ekle"),
         )
    );
  }

  addTask(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: TextField(
              autofocus: true,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                  hintText: "Görev Nedir?",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
              ),
              onSubmitted: (value){
                Navigator.pop(context);
                if(value.length>3){
                  DatePicker.showTimePicker(context,showSecondsColumn: false,
                      onConfirm: (time) {
                        var newTask = Task.create(name: value, time: time);
                        allTasks.add(newTask);
                        localStorage.addTask(task: newTask);
                        setState((){});
                      }
                  );
                }

              },
            ),
          );
        }
    );
  }

  void getAllTaskFromDb() async{
    allTasks = await localStorage.getAllTask();
    setState(() {

    });
  }
}
