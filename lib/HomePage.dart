import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todo_app_flutter/models/Task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: Text("Merhaba"),
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
