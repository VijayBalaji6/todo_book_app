import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/model/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoLoading()) {
    on<LoadTodoEvent>(_onLoadTodo);
    on<AddTodoEvent>(_onAddTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
    on<EditTodoEvent>(_onEditTodo);
  }

  void _onLoadTodo(LoadTodoEvent event, Emitter<TodoState> emit) {
    emit(TodoLoaded(todoList: event.todos));
  }

  void _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) {
    final state = this.state;
    if (state is TodoLoaded) {
      emit(TodoLoaded(todoList: List.from(state.todoList)..add(event.todo)));
    }
  }

  void _onDeleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) {
    final state = this.state;
    if (state is TodoLoaded) {
      List<TodoModel> todosAfterDeletion =
          state.todoList.where((e) => e.id != event.todo.id).toList();
      emit(TodoLoaded(todoList: todosAfterDeletion));
    }
  }

  void _onEditTodo(EditTodoEvent event, Emitter<TodoState> emit) {
    final state = this.state;
    if (state is TodoLoaded) {
      List<TodoModel> editedTodoList = state.todoList.map((element) {
        return element.id == event.todo.id ? event.todo : element;
      }).toList();
      emit(TodoLoaded(todoList: editedTodoList));
    }
  }
}
