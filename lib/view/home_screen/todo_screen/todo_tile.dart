import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo/todo_bloc.dart';
import 'package:todo/common_widgets/common_widgets.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/view/home_screen/todo_screen/add_edit_todo_screen.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    super.key,
    required this.context,
    required this.todo,
    required this.index,
  });

  final BuildContext context;
  final Todo todo;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => AddEditTodoScreen(
                      todo: todo,
                      userId: todo.userID,
                    ))),
          ),
          IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () => CommonStylesAndWidget.commonPopupWidget(
                  context: context,
                  popUpTitle: 'Delete Task',
                  popUpContent: 'Do you want to delete the Task',
                  positiveButtonName: 'Delete',
                  negativeButtonName: 'Cancel',
                  positiveButtonAction: () {
                    context.read<TodoBloc>().add(DeleteTodoEvent(todo: todo));
                  })),
        ],
      ),
      title: Text(
        todo.title,
        style: const TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w800),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (todo.note != null)
            Text(
              todo.note!,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          Text(
            todo.content,
            style: const TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.timer),
              Text(
                todo.todoTime.toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
