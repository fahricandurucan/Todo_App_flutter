import 'package:flutter/material.dart';
import 'package:todo_app_flutter/data/LocalStorage.dart';
import 'package:todo_app_flutter/main.dart';
import 'package:todo_app_flutter/models/Task.dart';
import 'package:todo_app_flutter/widgets/TaskListItem.dart';

class CustomSearchDelegate extends SearchDelegate{

  late List<Task> allTask;

  CustomSearchDelegate({required this.allTask});



  @override
  List<Widget>? buildActions(BuildContext context) {  //appbaar ın sağ kısmı
    return [
      IconButton(
          onPressed: (){
            query.isEmpty ? null : query = "";
          },
          icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {   //appbaar ın sol kısmı
    return IconButton(
        onPressed: (){
          close(context, null);
        }, 
        icon: Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {  //arama yapıp arama butonuna bastıktan sonra çıkacaklar için
    var filteredList = allTask.where((task) => 
      task.name.toLowerCase().contains(query.toLowerCase())).toList();
    return filteredList.length>0 ?
    ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context,index){
          var task = filteredList[index];
          return Dismissible(
            background: Container(
              color: Colors.redAccent,
              alignment: Alignment.center,
              child: Text("Silindi",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
            ),
            key: UniqueKey(),
            direction: DismissDirection.startToEnd,
            onDismissed: (x) async{
                filteredList.removeAt(index);
                await locator<LocalStorage>().deleteTask(task: task);
            },
            child: TaskListItem(task: task,),
          );
        }
    ) :
        Center(child: Text("Aranacak görev bulunamadı!"),);
  }

  @override
  Widget buildSuggestions(BuildContext context) {   // bir iki harf yazdığımızda
    return Container();
  }

}