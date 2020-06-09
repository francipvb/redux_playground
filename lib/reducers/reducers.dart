import 'package:redux/redux.dart';

import '../actions/actions.dart';
import '../models/models.dart';

AppState mainReducer(AppState state, action) => AppState(
      todos: modifyTodoList(state?.todos, action) ?? TodoList(),
    );

final todoListReducer = combineReducers<List<TodoItem>>([
  TypedReducer(addTodo),
  TypedReducer(deleteTodo),
  TypedReducer(updateTodo),
  TypedReducer(completeTodo),
]);

final todosReducer = combineReducers<TodoList>([
  TypedReducer(modifyTodoList),
]);

List<TodoItem> addTodo(List<TodoItem> state, AddTodo action) =>
    List.unmodifiable(
      state.toList()
        ..add(TodoItem(
          text: action.text,
        )),
    );

List<TodoItem> deleteTodo(List<TodoItem> state, DeleteTodo action) =>
    List.unmodifiable(state.where((element) => element != state[action.index]));

List<TodoItem> updateTodo(List<TodoItem> state, UpdateTodo action) =>
    List.unmodifiable(
      state.map(
        (element) => element != state[action.index]
            ? element
            : TodoItem(
                completed: element.completed,
                completionDate: element.completionDate,
                text: action.text,
              ),
      ),
    );

List<TodoItem> completeTodo(List<TodoItem> state, CompleteTodo action) =>
    List.unmodifiable(
      state.map(
        (item) => item == state[action.index] && !item.completed
            ? TodoItem(
                completed: true,
                completionDate: DateTime.now(),
                text: item.text,
              )
            : item,
      ),
    );

TodoList modifyTodoList(TodoList state, EditTodoListAction action) => TodoList(
      lastUpdate: DateTime.now(),
      isInvalidated: state?.isInvalidated,
      todoItems: todoListReducer(state?.todoItems, action) ?? const [],
    );
