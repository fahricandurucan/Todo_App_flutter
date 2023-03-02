import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'Task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject{
  @HiveField(0)
  late String id;
  
  @HiveField(1)
  late String name;
  
  @HiveField(2)
  late DateTime time;
  
  @HiveField(3)
  late bool isCompleted;

  Task({required this.id, required this.name, required this.time, required this.isCompleted});
  factory Task.create({required String name, required DateTime time}){
    return Task(id: Uuid().v1(), name: name, time: time, isCompleted: false);
  }
}