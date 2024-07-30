import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_bloc/bloc/to_do_bloc.dart.dart';
import 'package:todo_bloc/bloc/to_do_event.dart.dart';
import 'package:todo_bloc/constant/constants.dart';
import 'package:todo_bloc/model/to_do_model.dart';
import 'package:todo_bloc/presentation/widgets/textbutton_widget.dart';
import 'package:todo_bloc/presentation/widgets/textform_widget.dart';

class ToDoList extends StatelessWidget {
  final List<ToDoModel> toDoList;

  const ToDoList({super.key, required this.toDoList});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return toDoList.isEmpty
        ? const Center(
            child: Text("No ToDo Here"),
          )
        : AnimationLimiter(
            child: ListView.builder(
              padding: EdgeInsets.all(w / 30),
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: toDoList.length,
              itemBuilder: (BuildContext context, int index) {
                ToDoModel toDo = toDoList[index];
                TextEditingController titleEditingController =
                    TextEditingController(text: toDo.title);
                TextEditingController descriptionEditingController =
                    TextEditingController(text: toDo.description);
                return AnimationConfiguration.staggeredList(
                  position: index,
                  delay: const Duration(milliseconds: 100),
                  child: SlideAnimation(
                    duration: const Duration(milliseconds: 2500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    horizontalOffset: -300,
                    verticalOffset: -850,
                    child: Container(
                      margin: EdgeInsets.only(bottom: w / 20),
                      height: w / 4,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 40,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          toDo.title,
                          style: GoogleFonts.openSans(
                              color: blkClr,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(
                          toDo.description,
                          style: GoogleFonts.openSans(
                              color: blkClr,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: blkClr,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: whiteClr,
                                      title: Text(
                                        'Edit ToDo',
                                        style: GoogleFonts.openSans(
                                            fontSize: 20,
                                            color: blkClr,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      content: SizedBox(
                                        height: 300,
                                        child: Column(
                                          children: [
                                            TextFormWidgets(
                                              controller:
                                                  titleEditingController,
                                              labelText: 'Title',
                                            ),
                                            kHeight20,
                                            TextFormWidgets(
                                              controller:
                                                  descriptionEditingController,
                                              labelText: ' Description',
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButtonWidget(
                                          onPressedName: 'Cancel',
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        TextButtonWidget(
                                          onPressedName: 'Save',
                                          onPressed: () {
                                            context
                                                .read<ToDoBloc>()
                                                .add(UpdateToDoEvent(
                                                    updateTodo: ToDoModel(
                                                  title: titleEditingController
                                                      .text,
                                                  description:
                                                      descriptionEditingController
                                                          .text,
                                                  isCompleted: false,
                                                )));
                                            context.read<ToDoBloc>().add(
                                                FetachInitialToDoListEvent());

                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: blkClr,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: whiteClr,
                                      title: Text(
                                        'Confirm Deletion',
                                        style: textStyle,
                                      ),
                                      content: Text(
                                        'Are you sure you want to delete this task?',
                                        style: textStyle,
                                      ),
                                      actions: [
                                        TextButton(
                                          style: buttonStyle2,
                                          onPressed: () {
                                            Navigator.pop(
                                                context); // Close the confirmation dialog
                                          },
                                          child: Text(
                                            'Cancel',
                                            style: textStyle2,
                                          ),
                                        ),
                                        TextButton(
                                          style: buttonStyle2,
                                          onPressed: () {
                                            // Delete the task and close the confirmation dialog
                                            context
                                                .read<ToDoBloc>()
                                                .add(DeleteTodo(
                                                  todoId: toDo.id!,
                                                ));
                                            context.read<ToDoBloc>().add(
                                                FetachInitialToDoListEvent());
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Delete',
                                            style: textStyle2,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            Checkbox(
                              checkColor: blkClr,
                              // Checkbox for completion status
                              value: toDo.isCompleted,
                              onChanged: (value) {
                                // Toggle completion status
                                context.read<ToDoBloc>().add(
                                      UpdateToDoEvent(
                                        updateTodo: ToDoModel(
                                          id: toDo.id,
                                          title: toDo.title,
                                          description: toDo.description,
                                          isCompleted: value!,
                                        ),
                                      ),
                                    );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
