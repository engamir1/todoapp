import 'package:bmi/todo/task_cubit/task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoMainPage extends StatefulWidget {
  const TodoMainPage({super.key});

  @override
  State<TodoMainPage> createState() => _TodoMainPageState();
}

class _TodoMainPageState extends State<TodoMainPage> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<TaskCubit>(context);
    return BlocConsumer<TaskCubit, TaskState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueAccent,
              title: const Text(
                "Task App",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: cubit.bottomWidgetsPages[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.blue[200],
                showUnselectedLabels: true,
                onTap: (index) {
                  print(index);
                  // Change curr index
                  cubit.changeIndex(index);
                },
                items: cubit.bottomItems),
          );
        },
        listener: (context, state) {});
  }
}
