//eğer hive yerine başka bir veri tabanı yapısı kullanırsak(sqlite vs.)
//widget daki kod yapımız değişmesin diye abstract class kullanabiliriz

import 'package:todo_app_flutter/models/Task.dart';

abstract class LocalStorage{
  Future<void> addTask({required Task task});
  Future<Task> getTask({required String id});
  Future<List<Task>> getAllTask();
  Future<bool> deleteTask({required Task task});
  Future<Task> updateTask({required Task task});
}

class HiveLocalStorage extends LocalStorage{
  @override
  Future<void> addTask({required Task task}) {
    // TODO: implement addTask
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteTask({required Task task}) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getAllTask() {
    // TODO: implement getAllTask
    throw UnimplementedError();
  }

  @override
  Future<Task> getTask({required String id}) {
    // TODO: implement getTask
    throw UnimplementedError();
  }

  @override
  Future<Task> updateTask({required Task task}) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
  
}