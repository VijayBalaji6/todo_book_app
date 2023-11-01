import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo/todo_bloc.dart';
import 'package:todo/helper/ui_helper/common_widgets.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/view/todo_screen/add_edit_todo_screen.dart';

class TodoHomeScreen extends StatelessWidget {
  const TodoHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'To-Do',
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const AddEditTodoScreen())),
        ),
        backgroundColor: Colors.white,
        body: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TodoLoaded) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Column(
                children: [
                  /// App Home Page Title
                  const Text(
                    "List Of Todos",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  /// List Of Todos
                  Expanded(
                    child: Scrollbar(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.todoList.length,
                          itemBuilder: ((context, index) {
                            final currentTodo = state.todoList[index];
                            return todoTile(
                                context: context,
                                todo: currentTodo,
                                index: index + 1);
                          })),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is TodoError) {
            return const Center(
              child: Text('Error Loading Todo'),
            );
          } else {
            return const Center(
              child: Text('Something Went Wrong'),
            );
          }
        }));
  }

  ListTile todoTile(
      {required BuildContext context,
      required TodoModel todo,
      required int index}) {
    return ListTile(
      leading: Text(
        index.toString(),
        style: const TextStyle(
            color: Colors.blue, fontSize: 18, fontWeight: FontWeight.w800),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => AddEditTodoScreen(
                      todo: todo,
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
        ],
      ),
    );
  }
}
