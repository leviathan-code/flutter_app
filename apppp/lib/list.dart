import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreen();
}

class _ListScreen extends State<ListScreen> {
  List _tasks = [];
  String _getTasksResponse = '';

  void _getTasks() async {
    final url = Uri.parse('http://0.0.0.0:8000/api');
    final response = await http.get(
      url,
      headers: {
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        _getTasksResponse = response.body;
        _tasks = json.decode(response.body);
      });
    } else {
      setState(() {
        _getTasksResponse =
        'Request failed with status: ${response.statusCode}.';
        _tasks = [];
      });
    }
  }

  String _postTaskTitle = '';
  String _postTaskDescription = '';

  void _postTask() async {
    final formKey = GlobalKey<FormState>();
    String title = '';
    String description = '';

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a title';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      title = value!;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                    onSaved: (value) {
                      description = value!;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final form = formKey.currentState;
                if (form != null && form.validate()) {
                  form.save();
                  Navigator.pop(context);
                  _addTask(title, description);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _addTask(String title, String description) async {
    final url = Uri.parse('http://0.0.0.0:8000/api');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
      body: jsonEncode({
        'title': title,
        'description': description,
      }),
    );

    if (response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      setState(() {
        _tasks.add(jsonData);
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return ListTile(
                  title: Text(task['title']),
                  subtitle: Text(task['description']),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _postTask,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}