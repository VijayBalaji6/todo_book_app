import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo/todo_bloc.dart';
import 'package:todo/helper/ui_helper/common_widgets.dart';
import 'package:todo/model/todo.dart';

class AddEditTodoScreen extends StatefulWidget {
  const AddEditTodoScreen({super.key, this.todo});
  final Todo? todo;

  @override
  State<AddEditTodoScreen> createState() => _AddEditTodoScreenState();
}

class _AddEditTodoScreenState extends State<AddEditTodoScreen> {
  final TextEditingController todoTitle = TextEditingController();

  final TextEditingController todoDetail = TextEditingController();

  final TextEditingController todoNote = TextEditingController();

  Todo? editTodoData;
  @override
  void initState() {
    editTodoData = widget.todo;
    if (editTodoData != null) {
      todoTitle.text = editTodoData!.title;
      todoDetail.text = editTodoData!.content;
      todoNote.text = editTodoData!.note ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool editTodo = editTodoData != null;
    return Scaffold(
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoLoaded) {
            CommonStylesAndWidget.showSnackbar(
                context: context,
                snackBarMessage:
                    editTodo ? "Todo is edited " : "Todo is added ");
          } else if (state is TodoLoaded) {
            CommonStylesAndWidget.showSnackbar(
                context: context, snackBarMessage: "Todo is Edited");
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              if (editTodo)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Todo Id : ${editTodoData!.id}",
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: todoTitle,
                decoration: CommonStylesAndWidget.textfieldDecoration(
                    hintTitle: "Title"),
                style: const TextStyle(),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: todoDetail,
                decoration: CommonStylesAndWidget.textfieldDecoration(
                    hintTitle: "Description"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: todoNote,
                decoration: CommonStylesAndWidget.textfieldDecoration(
                    hintTitle: "Hint (optional)"),
              ),
              const SizedBox(
                height: 30,
              ),
              CommonStylesAndWidget.commonAppButton(
                  buttonName: editTodo ? 'Edit Todo' : 'Add Todo',
                  buttonAction: () {
                    final Todo todoData = Todo(
                      userID: "",
                      title: todoTitle.text,
                      id: editTodo
                          ? editTodoData!.id
                          : DateTime.now().toString(),
                      content: todoDetail.text,
                      note: todoNote.text.trim().isNotEmpty
                          ? todoNote.text.trim()
                          : null,
                      todoStatus: editTodo
                          ? editTodoData!.todoStatus
                          : TodoStatus.active,
                    );
                    if (editTodo) {
                      context
                          .read<TodoBloc>()
                          .add(EditTodoEvent(todo: todoData));
                    } else {
                      context
                          .read<TodoBloc>()
                          .add(AddTodoEvent(todo: todoData));
                    }

                    Navigator.of(context).pop();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
