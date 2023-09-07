import 'package:flutter/material.dart';

// class DoneView extends StatelessWidget {
//   const DoneView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text("Done"),
//     );
//   }
// }

import 'package:bmi/todo/models/task_model.dart';
import 'package:bmi/todo/task_cubit/task_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoneView extends StatelessWidget {
  const DoneView({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TaskCubit>(context).fetchDoneTasks();

    return Scaffold(
      body: BlocConsumer<TaskCubit, TaskState>(
        listener: (context, state) {},
        builder: (context, state) {
          List<TaskModel> doneTasks =
              BlocProvider.of<TaskCubit>(context).doneTasks;

          return Center(
            child: ListView.builder(
              itemCount: doneTasks.length,
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
                            doneTasks[ids].time,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doneTasks[ids].title,
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              "date of : ${doneTasks[ids].date}",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            doneTasks[ids].delete();
                            doneTasks[ids].status = false;
                            BlocProvider.of<TaskCubit>(context)
                                .fetchDoneTasks();
                          },
                        ),
                        Checkbox(
                          value: doneTasks[ids].status,
                          onChanged: (statsu) {
                            // when click changhe status
                            BlocProvider.of<TaskCubit>(context)
                                .changeStatus(statsu!);
                            // get new value of task from cubit
                            doneTasks[ids].status =
                                BlocProvider.of<TaskCubit>(context).status;

                            // this line will rebuild screen after change status of task
                            BlocProvider.of<TaskCubit>(context)
                                .fetchDoneTasks();
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
    );
  }
}
