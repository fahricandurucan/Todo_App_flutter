import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todo_app_flutter/models/Task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<Task> allTasks;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allTasks = <Task>[];
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
                  setState(() {
                    allTasks.removeAt(index);
                  });
                },
                child: ListTile(
                  title: Text(task.name),
                  subtitle: Text(task.time.toString()),
                ),
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
                      onConfirm: (time){
                        var newTask = Task.create(name: value, time: time);
                        setState(() {
                          allTasks.add(newTask);
                        });
                      }
                  );
                }

              },
            ),
          );
        }
    );
  }
}
