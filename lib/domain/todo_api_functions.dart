import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_bloc/model/to_do_model.dart';

const String todoApiUrl = 'https://api.nstack.in/v1/todos?page=1&limit=10';
final Uri todoApiUri = Uri.parse(todoApiUrl);

class ToDoApiFunctions {
  Future<List<ToDoModel>> fetchtodoList() async {
    List<ToDoModel> toDoList = [];

    try {
      final response = await http.Client().get(todoApiUri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responsedata = jsonDecode(response.body);
        final List items = responsedata['items'];

        for (var i = 0; i < items.length; i++) {
          ToDoModel todo = ToDoModel.fromJson(items[i]);
          toDoList.add(todo);
        }
      }
      return toDoList;
    } catch (e) {
      final String error = 'Error loading the data: $e';
      // ignore: avoid_print
      print(error);
      return [];
    }
  }

  Future<bool> addToDoModel({required ToDoModel toDo}) async {
    try {
      final response = await http.Client().post(todoApiUri,
          body: jsonEncode(toDo),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      // ignore: avoid_print
      print('Error adding ToDoModel: $e');
      return false;
    }
  }

  Future<bool> updateToDoModel({required ToDoModel updateTodo}) async {
    final client = http.Client();
    try {
      final response = await http.Client().put(
        Uri.parse(todoApiUrl),
        body: jsonEncode(updateTodo),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('API error updating ToDo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating ToDoModel: $e');
    } finally {
      client.close(); // Close the client if injected
    }
  }

  Future<bool> deleteToDoModel({required String todoId}) async {
    try {
      final response = await http.Client().delete(
        Uri.parse('$todoApiUrl/$todoId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('API error deleting ToDo: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exception
      print('Error deleting ToDoModel: $e');
      return false;
    }
  }
}
