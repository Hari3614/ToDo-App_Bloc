import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_bloc/bloc/to_do_bloc.dart.dart';
import 'package:todo_bloc/bloc/to_do_event.dart.dart';
import 'package:todo_bloc/constant/constants.dart';
import 'package:todo_bloc/model/to_do_model.dart';
import 'package:todo_bloc/presentation/widgets/textform_widget.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    Key? key, // Corrected the key parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      right: 30,
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          showDialogs(context);
        },
        child: const Icon(
          size: 30,
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }

  void showDialogs(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: whiteClr,
          title: Text(
            "Add To Do",
            style: GoogleFonts.roboto(
                fontSize: 20, color: blkClr, fontWeight: FontWeight.w900),
          ),
          content: Column(
            mainAxisSize:
                MainAxisSize.min, // Use min to make the dialog compact
            children: [
              TextFormWidgets(
                controller: titleController,
                hintText: 'Title',
                labelText: 'Title',
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormWidgets(
                controller: descriptionController,
                hintText: 'Description',
                labelText: 'Description',
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        if (titleController.text.isNotEmpty &&
                            descriptionController.text.isNotEmpty) {
                          context.read<ToDoBloc>().add(AddToDoEvents(
                              toDo: ToDoModel(
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  isCompleted: false)));
                          snackBarForAdd(context);
                          context
                              .read<ToDoBloc>()
                              .add(FetachInitialToDoListEvent());
                          Navigator.pop(context);
                        } else {
                          snackBars(context);
                        }
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black)),
                      child: Text("Add", style: buttonStyle))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

void snackBars(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    animation: kAlwaysDismissedAnimation,
    content: Text('Write Your ToDo'),
    backgroundColor: Colors.red,
  ));
}

void snackBarForAdd(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    animation: kAlwaysDismissedAnimation,
    content: Text('ToDo Add SuccessFully'),
    backgroundColor: Colors.green,
  ));
}
