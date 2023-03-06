//eğer hive yerine başka bir veri tabanı yapısı kullanırsak(sqlite vs.)
//widget daki kod yapımız değişmesin diye abstract class kullanabiliriz

import 'package:hive/hive.dart';
import 'package:todo_app_flutter/models/Task.dart';

abstract class LocalStorage{
  Future<void> addTask({required Task task});
  Future<Task?> getTask({required String id});
  Future<List<Task>> getAllTask();
  Future<bool> deleteTask({required Task task});
  Future<Task> updateTask({required Task task});
}

class HiveLocalStorage extends LocalStorage{
  late Box<Task> taskBox;

  HiveLocalStorage(){
    taskBox = Hive.box<Task>("tasks");
  }
  
  @override
  Future<void> addTask({required Task task}) async{
    await taskBox.put(task.id, task);
  }

  @override
  Future<bool> deleteTask({required Task task}) async{
    await taskBox.delete(task.id);
    return true;
  }

  @override
  Future<List<Task>> getAllTask() async{
    List<Task> allTask = [];
    allTask = taskBox.values.toList();
    return allTask;
  }

  @override
  Future<Task?> getTask({required String id}) async{
    if(taskBox.containsKey(id)){
      return taskBox.get(id);
    }
    else{
      return null;
    }
  }

  @override
  Future<Task> updateTask({required Task task}) async{
    await task.save();
    return task;
  }
  
}