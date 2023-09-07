// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bmi/todo/task_cubit/task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:bmi/todo/models/task_model.dart';

import 'form_field.dart';

class TaskBottomSheet extends StatefulWidget {
  const TaskBottomSheet({
    super.key,
  });

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  final GlobalKey<FormState> formkey = GlobalKey();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formkey,
        child: Container(
          padding: EdgeInsets.only(
              left: 12.0,
              right: 12,
              top: 12,
              bottom: MediaQuery.of(context).viewInsets.bottom + 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                        size: 30,
                      ),
                    ),
                    const Text('Add new task.'),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.done,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                CustomInputField(
                    controller: titleController,
                    iconData: Icons.abc,
                    onSaved: (titlValue) {},
                    hintText: "task title",
                    maxLength: 25,
                    helpText: "this is helper text"),
                const SizedBox(height: 15),
                CustomInputField(
                  iconData: Icons.watch,
                  helpText: "choose time",
                  controller: timeController,
                  onSaved: (titlValue) {},
                  hintText: "Choose Time",
                  onTap: () async {
                    var time = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    setState(() {
                      timeController.text = (time!.format(context));
                    });
                  },
                ),
                const SizedBox(height: 15),
                CustomInputField(
                  iconData: Icons.calendar_month,
                  helpText: "choose Date",
                  controller: dateController,
                  onSaved: (titlValue) {},
                  hintText: "Choose Date",
                  onTap: () async {
                    var date = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        initialDate: DateTime.now(),
                        lastDate: DateTime.now());
                    setState(() {
                      //  date = DateTime.parse(date.toString());
                      var formattedDate =
                          DateFormat('dd/MM/yyyy').format(date!);
                      dateController.text = formattedDate.toString();
                    });
                  },
                ),
                const SizedBox(height: 150),
                AddButtonWidget(
                  formkey: formkey,
                  task: TaskModel(
                      title: titleController.text,
                      date: dateController.text,
                      time: timeController.text),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddButtonWidget extends StatelessWidget {
  const AddButtonWidget({
    Key? key,
    required this.formkey,
    required this.task,
  }) : super(key: key);

  final GlobalKey<FormState> formkey;
  final TaskModel task;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
        ),
        onPressed: () {
          if (formkey.currentState!.validate()) {
            formkey.currentState!.save();
            BlocProvider.of<TaskCubit>(context).addTask(task);
            // we fetch data after add to rebuild the scree
            BlocProvider.of<TaskCubit>(context).fetchAllTasks();
            Navigator.pop(context);
          } else {}
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(12)),
          width: double.infinity,
          child: const Center(
            child: Text(
              "Add Task",
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
  }
}
