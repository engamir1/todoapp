// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String date;
  @HiveField(2)
  String time;
  @HiveField(3)
  bool status;
  TaskModel({
    required this.title,
    required this.date,
    required this.time,
    this.status = false,
  });
}
