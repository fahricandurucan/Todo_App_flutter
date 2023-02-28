import 'package:uuid/uuid.dart';

class Task{
  late String id;
  late String name;
  late DateTime time;
  late bool isCompleted;

  Task({required this.id, required this.name, required this.time, required this.isCompleted});
  factory Task.create({required String name, required DateTime time}){
    return Task(id: Uuid().v1(), name: name, time: time, isCompleted: false);
  }
}