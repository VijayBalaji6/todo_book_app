import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo/todo_bloc.dart';
import 'package:todo/common_widgets/common_app_button.dart';
import 'package:todo/model/user.dart';
import 'package:todo/view/home_screen/todo_screen/add_edit_todo_screen.dart';
import 'package:todo/view/home_screen/todo_screen/todo_tile.dart';

class TodoHomeScreen extends StatelessWidget {
  final UserModel userData;

  const TodoHomeScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => AddEditTodoScreen(
                      userId: userData.userId,
                    ))),
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
              if (state is TodoLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TodoLoaded) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ///
                          Text(
                            "Today's Todo",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.notifications)
                        ],
                      ),

                      /// List Of Todos
                      Expanded(
                        child: Scrollbar(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.todoList.length,
                              itemBuilder: ((context, index) {
                                final currentTodo = state.todoList[index];
                                return TodoTile(
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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text('Error Loading Todo'),
                    ),
                    CommonAppButton(
                      buttonAction: () async {
                        context
                            .read<TodoBloc>()
                            .add(LoadTodoEvent(userId: userData.userId));
                      },
                      buttonName: 'retry',
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text('Something Went Wrong'),
                );
              }
            }),
          )),
    );
  }
}
