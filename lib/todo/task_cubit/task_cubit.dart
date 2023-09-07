import 'package:bloc/bloc.dart';
import 'package:bmi/todo/models/task_model.dart';
import 'package:bmi/todo/views/archive.dart';
import 'package:bmi/todo/views/done.dart';
import 'package:bmi/todo/views/settings.dart';
import 'package:bmi/todo/views/tasks.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  List<TaskModel> tasks = [];
  List<TaskModel> doneTasks = [];
  bool status = false;
// list of pages in bottom bar
  final List<Widget> bottomWidgetsPages = [
    const TasksView(),
    const DoneView(),
    const ArchiveView(),
    const SettingsView(),
  ];

  List<BottomNavigationBarItem> bottomItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(icon: Icon(Icons.menu), label: "tasks"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.check_box_outlined), label: "done"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.archive_outlined), label: "archive"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: "settings"),
  ];
  // curr index of index
  int currentIndex = 0;

  changeIndex(int index) {
    currentIndex = index;
    emit(ChangePage());
  }

  addTask(TaskModel task) async {
    emit(TaskLoading());
    try {
      var box = Hive.box<TaskModel>("todos");
      await box.add(task);
      emit(TaskSuccess());
    } on Exception catch (e) {
      // TODO
      print("ther errr i s $e");
    }

    // tasks = box.values.toList().reversed.toList();
  }

  fetchAllTasks() async {
    emit(TaskLoading());
    var box = Hive.box<TaskModel>("todos");

    tasks = box.values.toList().reversed.toList();
    // print(tasks);
    emit(TaskSuccess());
  }

  changeStatus(bool taskstatus) {
    status = taskstatus;
    emit(ChangeStatus());
  }

  fetchDoneTasks() async {
    emit(TaskLoading());
    doneTasks = tasks.where((task) => task.status == true).toList();

    // print(tasks);
 
    emit(CompletedTasks());
  }
}
