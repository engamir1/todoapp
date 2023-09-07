import 'package:bmi/todo/models/task_model.dart';
import 'package:bmi/todo/task_cubit/task_cubit.dart';
import 'package:bmi/todo/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksView extends StatelessWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TaskCubit>(context).fetchAllTasks();

    return Scaffold(
      body: BlocConsumer<TaskCubit, TaskState>(
        listener: (context, state) {},
        builder: (context, state) {
          List<TaskModel> tasks = BlocProvider.of<TaskCubit>(context).tasks;

          return Center(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, ids) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    child: Row(
                      children: [
                        CircleAvatar(
                          // backgroundColor: Colors.red,
                          radius: 40,
                          // minRadius: 150,
                          child: Text(
                            tasks[ids].time,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tasks[ids].title,
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              "date of : ${tasks[ids].date}",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            print(" the length is ${tasks.length}");
                            tasks[ids].delete();
                            BlocProvider.of<TaskCubit>(context).fetchAllTasks();
                          },
                        ),
                        Checkbox(
                          value: tasks[ids].status,
                          onChanged: (statsu) {
                            BlocProvider.of<TaskCubit>(context)
                                .changeStatus(statsu!);
                            tasks[ids].status =
                                BlocProvider.of<TaskCubit>(context).status;
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      // Fab Button
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FloatingActionButton.extended(
          elevation: 10,
          label: const Text("Make New Task.."),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15.0),
                  ),
                ),
                context: context,
                builder: (context) {
                  return const TaskBottomSheet();
                });
          },
          // child: const Text("Add New Task.."),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
