import 'package:test/test.dart';

import 'package:redux_playground/actions/actions.dart';
import 'package:redux_playground/models/models.dart';
import 'package:redux_playground/reducers/reducers.dart';

main() {
  test('Sets up initial data correctly.', () {
    final state = mainReducer(null, null);
    expect(state, isNotNull);
    expect(state.todos, isNotNull);
  });
  group('Model tests', () {
    final todo1 = TodoItem(
      completed: false,
      completionDate: null,
      text: "TODO item",
    );
    final todo2 = TodoItem(
      completed: false,
      completionDate: null,
      text: "TODO item",
    );
    final todo3 = TodoItem(
      completed: false,
      completionDate: null,
      text: "Another TODO item",
    );
    final todos1 = TodoList(
      todoItems: [todo1, todo3],
    );
    final todos2 = TodoList(
      todoItems: [todo2, todo3],
    );
    final state1 = AppState(
      todos: todos1,
    );
    final state2 = AppState(
      todos: todos2,
    );
    test('Todo items are equal', () {
      expect(todo1, todo2);
    });
    test('Todo items hash codes are the same', () {
      expect(todo1.hashCode, todo2.hashCode);
    });

    test('ToDo states are equal', () {
      expect(todos1, todos2);
    });
    test('Todo list hash codes are equal', () {
      expect(todos1.hashCode, todos2.hashCode);
    });
    test('App state are equal', () {
      expect(state1, state2);
    });
    test('App state hash codes are equal', () {
      expect(state1.hashCode, state2.hashCode);
    });
  });

  group('Test of action classes', () {
    final addTodo1 = AddTodo("Todo text");
    final addTodo2 = AddTodo("Todo text");
    final addTodo3 = AddTodo("Another todo");
    test('Add todo actions are equal', () {
      expect(addTodo1, addTodo2);
    });
    test('Ad todo instances are not equal', () {
      expect(addTodo1, predicate((v) => v != addTodo3));
    });
    test('Add todo action hash codes are equal', () {
      expect(addTodo1.hashCode, addTodo2.hashCode);
    });

    final completeTodo1 = CompleteTodo(index: 1);
    final completeTodo2 = CompleteTodo(index: 1);
    final completeTodo3 = CompleteTodo(index: 2);
    test('Complete actions are equal', () {
      expect(completeTodo1, completeTodo2);
    });
    test('Complete todo actions are not equal', () {
      expect(completeTodo1, isNot(equals(completeTodo3)));
    });
    test('Complete todo hash codes are equal', () {
      expect(completeTodo1.hashCode, completeTodo2.hashCode);
    });
    test('Complete todo hash codes are not equal', () {
      expect(completeTodo1.hashCode, isNot(equals(completeTodo3.hashCode)));
    });
  });
  group('Reducer tests', () {
    final todoList = const [
      TodoItem(text: "a todo item"),
      TodoItem(text: "Another todo item"),
    ];
    final todos = TodoList(todoItems: todoList);
    test('Add todo works', () {
      final second = addTodo(todoList, AddTodo("Todo text"));
      expect(second, hasLength(3));
    });
    test('Delete todo item works', () {
      final second = deleteTodo(todoList, DeleteTodo(index: 0));
      expect(second, hasLength(1));
    });
    test('Complete todo item action', () {
      final newList = completeTodo(todoList, CompleteTodo(index: 1));
      expect(newList[1].completed, true);
      expect(newList[1].completionDate, DateTime.now());
    });
    test('Test update todo action', () {
      final todoText = "Changed todo";
      final newList = updateTodo(todoList, UpdateTodo(1, todoText));
      expect(newList[1].text, todoText);
    });
    test('Test modify todo list object', () {
      final newTodoList = modifyTodoList(todos, AddTodo("A new todo item"));
      expect(DateTime.now().difference(newTodoList.lastUpdate).inSeconds,
          lessThan(1));
    });
  });
}
