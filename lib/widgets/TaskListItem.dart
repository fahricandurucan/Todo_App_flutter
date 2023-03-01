import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_flutter/models/Task.dart';

class TaskListItem extends StatefulWidget {

  TaskListItem({Key? key,required this.task}) : super(key: key);
  late Task task;


  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {

  TextEditingController taskController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskController.text = widget.task.name;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
        elevation: 4,
        child: ListTile(
          leading: GestureDetector(
            onTap: (){
              setState(() {
                widget.task.isCompleted = !widget.task.isCompleted; // reverse
              });
            },
            child: widget.task.isCompleted ? Icon(Icons.check_circle,color: Colors.green,size: 30,)
                                            :Icon(Icons.circle_outlined,size: 30,),
          ),
          title: widget.task.isCompleted ?
              Text(widget.task.name,style: TextStyle(fontSize: 18,color: Colors.grey,decoration: TextDecoration.lineThrough),)
              : TextField(
            style: TextStyle(fontSize: 18),
              controller: taskController,
              minLines: 1,
              maxLines: null,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            onSubmitted: (value){
                if(value.length>3){
                    widget.task.name = value;
                }
            },
          ),

          trailing: Text(DateFormat("hh:mm a").format(widget.task.time),style: TextStyle(fontSize: 16,color: Colors.grey),),
        ),
      ),
    );
  }
}
